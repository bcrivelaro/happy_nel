RSpec.feature 'Members', type: :feature do
  context 'logged in' do
    let(:admin) { create :admin }
    before { login_as(admin) }

    scenario 'creating a member' do
      visit new_member_path

      fill_in 'Nome', with: 'membro'
      fill_in 'Email', with: 'membro@email.com'

      expect do
        click_button 'Criar membro'
      end.to change { admin.members.count }.by(1)

      expect(page).to have_text('Membro criado com sucesso!')
    end
  end

  context 'logged out' do
    scenario 'try to create a member' do
      visit new_member_path

      expect(page.current_path).to eq(new_admin_session_path)
    end
  end
end