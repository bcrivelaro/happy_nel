class Survey < ApplicationRecord
  enum status: { running: 'running'.freeze, finished: 'finished'.freeze }

  belongs_to :admin
  has_many :survey_tokens
  has_and_belongs_to_many :members

  validates :question, presence: true
  validates :status, inclusion: { in: Survey.statuses.keys }
  validates :answer_count,
            presence: true,
            numericality: { only_integer: true }
  validates :average_rating, presence: true
end
