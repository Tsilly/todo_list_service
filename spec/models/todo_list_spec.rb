require 'rails_helper'

RSpec.describe TodoList, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:todo_items) }
  it { is_expected.to validate_presence_of(:title) }
end
