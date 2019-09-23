class Member < ApplicationRecord
  belongs_to :admin
  has_and_belongs_to_many :surveys

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { scope: :admin_id }
end
