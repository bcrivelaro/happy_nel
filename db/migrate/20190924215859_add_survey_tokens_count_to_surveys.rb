class AddSurveyTokensCountToSurveys < ActiveRecord::Migration[5.2]
  def change
    add_column :surveys, :survey_tokens_count, :integer, default: 0
  end
end
