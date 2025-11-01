FactoryBot.define do
  factory :task do
    name { "My task." }
    association :project
  end
end
