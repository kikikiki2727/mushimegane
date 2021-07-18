FactoryBot.define do
  factory :radar_chart do
    capture { 5 }
    breeding { 5 }
    prevention_difficulty { 5 }
    injury { 5 }
    discomfort { 5 }
    association :bug
  end
end