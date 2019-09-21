class SurveyToken < ApplicationRecord
  belongs_to :survey

  before_validation :generate_token, on: :create

  private

  def generate_token
    self.token = loop do
      token = SecureRandom.uuid.gsub(/\-/, '')
      break token unless self.class.exists?(token: token)
    end
  end
end
