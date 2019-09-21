class Admin < ApplicationRecord
  devise :database_authenticatable, :rememberable

  has_many :members
  has_many :surveys

  def can_create_survey?
    members.any?
  end
end
