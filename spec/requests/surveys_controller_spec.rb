RSpec.describe SurveysController, type: :request do
  context 'authenticated' do
    let(:admin) { create :admin }
    let(:valid_params) { { question: 'question' } }
    let(:invalid_params) { { question: '' } }

    before { sign_in admin }

    describe 'GET #index' do
      before do
        create_list :survey, 2, admin: admin
        get surveys_path
      end

      it { expect(response).to be_successful }
      it { expect(assigns(:surveys).all? { |t| t.is_a? Survey }).to eq(true) }
      it { expect(assigns(:surveys).map(&:admin).uniq).to eq([admin]) }
    end

    describe 'GET #new' do
      context 'when admin can create survey' do
        before do
          create_list :member, 2, admin: admin
          get new_survey_path
        end

        it { expect(response).to be_successful }
        it { expect(assigns(:survey)).to be_a_new(Survey) }
      end

      context 'when admin cannot create survey' do
        it 'redirects to members path' do
          get new_survey_path

          expect(response).to redirect_to(members_path)
          expect(flash[:error]).to be_present
        end
      end
    end

    describe 'POST #create' do
      context 'when admin can create survey' do
        before { create_list :member, 2, admin: admin }

        context 'valid data' do
          it 'creates a new survey' do
            expect do
              post surveys_path, params: { survey: valid_params }
            end.to change { admin.surveys.count }.by(1)
          end

          it 'redirects to surveys path' do
            post surveys_path, params: { survey: valid_params }

            expect(flash[:success]).to be_present
            expect(response).to redirect_to(surveys_path)
          end
        end

        context 'invalid data' do
          before { post surveys_path(params: { survey: invalid_params }) }

          it { expect(response).to be_successful }
          it { expect(response).to render_template(:new) }
          it { expect(assigns(:survey)).to be_a_new(Survey) }
        end
      end

      context 'when admin cannot create survey' do
        it 'redirects to members path' do
          post surveys_path, params: { survey: valid_params }

          expect(response).to redirect_to(members_path)
          expect(flash[:error]).to be_present
        end
      end
    end
  end

  context 'unauthenticated' do
    before { get surveys_path }

    it { expect(response).to redirect_to(new_admin_session_path) }
  end
end