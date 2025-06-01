FactoryBot.define do
  factory :user, aliases: [:owner] do
    first_name { "Tester" }
    last_name { "Example" }
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { "dottle-nouveau-pavilion-tights-furze" }

    trait :with_a_project do
      after(:create) { |user| create(:project, owner: user, name: 'Test Project') }
    end
  end
end
