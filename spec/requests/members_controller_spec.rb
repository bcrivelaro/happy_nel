RSpec.describe MembersController, type: :request do
  context 'authenticated' do
    let(:admin) { create :admin }
    let(:valid_params) { { name: 'member', email: 'member@email.com' } }
    let(:invalid_params) { { name: '' } }

    before { sign_in admin }

    describe 'GET #index' do
      before do
        create_list :member, 2, admin: admin
        get members_path
      end

      it { expect(response).to be_successful }
      it { expect(assigns(:members).all? { |t| t.is_a? Member }).to eq(true) }
      it { expect(assigns(:members).map(&:admin).uniq).to eq([admin]) }
    end

    describe 'GET #new' do
      before { get new_member_path }

      it { expect(response).to be_successful }
      it { expect(assigns(:member)).to be_a_new(Member) }
    end

    describe 'POST #create' do
      context 'valid data' do
        it 'creates a new member' do
          expect do
            post members_path, params: { member: valid_params }
          end.to change { admin.members.count }.by(1)
        end

        it 'redirects to members path' do
          post members_path, params: { member: valid_params }

          expect(flash[:success]).to be_present
          expect(response).to redirect_to(members_path)
        end
      end

      context 'invalid data' do
        before { post members_path(params: { member: invalid_params }) }

        it { expect(response).to be_successful }
        it { expect(response).to render_template(:new) }
        it { expect(assigns(:member)).to be_a_new(Member) }
      end
    end

    describe 'GET #edit' do
      let(:member) { create :member, admin: admin }
      before { get edit_member_path(member) }

      it { expect(response).to be_successful }
      it { expect(assigns(:member)).to eq(member) }
    end

    describe 'PATCH|PUT #update' do
      let(:member) { create :member, admin: admin }

      context 'valid data' do
        let(:data) { { name: 'new name' } }

        before { put member_path(member), params: { member: data } }

        it { expect(response).to redirect_to(members_path) }
        it { expect(flash[:success]).to be_present }
        it { expect(member.reload.name).to eq 'new name' }
      end

      context 'invalid data' do
        before { put member_path(member), params: { member: invalid_params } }

        it { expect(response).to render_template(:edit) }
        it { expect(assigns(:member)).to eq(member) }
        it { expect(assigns(:member).errors).to be_present }
      end
    end

    describe 'DELETE #destroy' do
      let(:member) { create :member, admin: admin }
      before { delete member_path(member) }

      it { expect(response).to redirect_to(members_path) }
      it { expect(flash[:success]).to be_present }
      it { expect(admin.members.count).to eq(0) }
    end
  end

  context 'unauthenticated' do
    before { get members_path }

    it { expect(response).to redirect_to(new_admin_session_path) }
  end
end