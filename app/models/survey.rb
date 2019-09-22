class Survey < ApplicationRecord
  enum status: { running: 'running'.freeze, finished: 'finished'.freeze }

  belongs_to :admin
  has_many :survey_tokens

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
