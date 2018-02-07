FactoryBot.define do
  factory :airport do
    sequence(:name) { |n| "Airport ##{n}" }
    sequence(:code) { |n| "Code ##{n}" }
    sequence(:city) { |n| "City ##{n}" }
    opened_on Date.today
  end
end
