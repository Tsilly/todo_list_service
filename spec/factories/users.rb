FactoryBot.define do
  factory :user do
    name            { 'MyString' }
    email           { Faker::Internet.email }
    password_digest { 'password' }
  end

  factory :user_with_todo_lists, parent: :user do
    after :create do |user|
      create_list :todo_list_with_todo_items, 2, user: user
    end
  end
end
