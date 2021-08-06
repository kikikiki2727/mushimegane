FactoryBot.define do
  factory :comment do
    sentence { 'コメントしました' }
    global_ip { '0.0.0.0' }
    association :bug
  end
end
