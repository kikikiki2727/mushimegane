FactoryBot.define do
  factory :bug do
    sequence(:name) { |n| "test_bug_name_#{n}" }
    feature { 'ここには特徴を入力します。' }
    approach { 'ここには駆除方法を入力します。' }
    prevention { 'ここには予防方法を入力します。' }
    harm { 'ここには実害を入力します。' }
    size { :medium }
    color { :black }
    season { :spring }
    association :user
  end
end
