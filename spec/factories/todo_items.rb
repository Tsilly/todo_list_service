FactoryBot.define do
  factory :todo_item do
    content { Faker::Hipster.sentence }
    todo_list

    trait :completed do
      completed_at { Time.zone.now }
    end
  end
end
