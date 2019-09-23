class CreateJoinTableMemberSurvey < ActiveRecord::Migration[5.2]
  def change
    create_join_table :members, :surveys do |t|
      t.index %i[member_id survey_id], unique: true
    end
  end
end
