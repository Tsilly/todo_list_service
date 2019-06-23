module Types
  class UserAuthAttributes < BaseInputObject
    description 'Properties for registering a new User'

    argument :email, String, required: true
    argument :password, String, required: true
  end
end