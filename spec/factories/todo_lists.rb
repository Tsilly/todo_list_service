FactoryBot.define do
  factory :todo_list do
    user
    title { Faker::Hipster.word }
    description { Faker::Hipster.sentence }

    factory :todo_list_with_todo_items do
      after :create do |todo_list|
        create :todo_item, todo_list: todo_list
        create :todo_item, :completed, todo_list: todo_list
      end
    end
  end
end
