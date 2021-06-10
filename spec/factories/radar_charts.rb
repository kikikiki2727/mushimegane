FactoryBot.define do
  factory :radar_chart do
    capture { 5 }
    breeding { 5 }
    quickness { 5 }
    evil { 5 }
    discomfort { 5 }
    association :bug
  end
end