class CreateMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.references :admin, foreign_key: true

      t.timestamps
    end
  end
end
