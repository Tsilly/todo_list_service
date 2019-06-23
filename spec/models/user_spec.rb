require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_many(:todo_lists) }
  it { is_expected.to validate_presence_of(:name) }
end
