class CreateSurveys < ActiveRecord::Migration[5.2]
  def change
    create_table :surveys do |t|
      t.references :admin, foreign_key: true
      t.string :question, null: false
      t.string :status, null: false, default: 'running'
      t.integer :answer_count, null: false, default: 0
      t.decimal :average_rating, precision: 4, scale: 2, null: false, default: 0

      t.timestamps
    end
  end
end
