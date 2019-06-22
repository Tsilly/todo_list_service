FactoryBot.define do
  factory :user do
    email     { Faker::Internet.email }
    password  { 'password' }

    factory :user_with_todo_list do
      after :create do |user|
        create :todo_list, 3, user: user
      end
    end
  end
end
