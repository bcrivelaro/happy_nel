class CreateSurveyTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :survey_tokens do |t|
      t.references :survey, foreign_key: true
      t.string :token, null: false

      t.timestamps
    end

    add_index :survey_tokens, :token, unique: true
  end
end
