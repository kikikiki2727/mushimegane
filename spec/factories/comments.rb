FactoryBot.define do
  factory :comment do
    sentence { 'コメントしました' }
    association :user
    association :bug
  end
end
