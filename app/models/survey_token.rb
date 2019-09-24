class SurveyToken < ApplicationRecord
  belongs_to :survey, counter_cache: true

  before_validation :generate_token, on: :create

  def can_be_used?
    used_at.nil?
  end

  private

  def generate_token
    self.token = loop do
      token = SecureRandom.uuid.gsub(/\-/, '')
      break token unless self.class.exists?(token: token)
    end
  end
end
