FactoryBot.define do
  factory :survey_token do
    survey
    used_at { nil }
  end
end
