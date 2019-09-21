class Admin < ApplicationRecord
  devise :database_authenticatable, :rememberable

  has_many :members
end
