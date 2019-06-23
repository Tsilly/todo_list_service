class User < ApplicationRecord
  has_secure_password

  has_many :todo_lists, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
end
