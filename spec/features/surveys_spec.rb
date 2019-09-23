RSpec.feature 'Surveys', type: :feature do
  context 'logged in' do
    let(:admin) { create :admin }

    scenario 'Admin with members creates a survey' do
      create_list :member, 2, admin: admin
      login_as(admin)

      visit new_survey_path
      fill_in 'Pergunta', with: 'pergunta'

      expect do
        click_button 'Criar pesquisa'
      end.to change { admin.surveys.count }.by(1)

      expect(page).to have_text('Pesquisa criada com sucesso!')
    end

    scenario 'Admin with no members creates a survey' do
      login_as(admin)

      visit new_survey_path

      expect(page.current_path).to eq(members_path)
      text = 'Você precisa ter ao menos um membro para criar uma pesquisa!'
      expect(page).to have_text(text)
    end
  end

  context 'logged out' do
    scenario 'try to create a survey a member' do
      visit new_survey_path

      expect(page.current_path).to eq(new_admin_session_path)
    end
  end
end
