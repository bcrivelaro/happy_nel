class Member < ApplicationRecord
  belongs_to :admin

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { scope: :admin_id }
end
