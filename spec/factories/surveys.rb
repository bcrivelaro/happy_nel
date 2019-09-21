FactoryBot.define do
  factory :survey do
    admin
    question { 'question' }
    status { 'running' }
    members_count { 5 }
    answer_count { 2 }
    average_rating { 8 }
  end
end
