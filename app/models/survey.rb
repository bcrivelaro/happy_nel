class Survey < ApplicationRecord
  enum status: { running: 'running', finished: 'finished' }

  belongs_to :admin

  validates :question, presence: true
  validates :status, inclusion: { in: Survey.statuses.keys }
  validates :members_count,
            presence: true,
            numericality: { only_integer: true, greater_than: 0 }
  validates :answer_count,
            presence: true,
            numericality: { only_integer: true }
  validates :average_rating, presence: true
end
