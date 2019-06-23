module Mutations
  class SignInUser < Mutations::BaseMutation
    null true

    graphql_name 'Signin'

    argument :auth_attributes, Types::UserAuthAttributes, required: false

    field :token, String, null: true
    field :user, Types::UserType, null: true

    def resolve(auth_attributes:)
      return unless auth_attributes[:email]

      user = User.find_by(email: auth_attributes[:email])

      return unless user
      return unless user.authenticate(auth_attributes[:password])

      crypt = ActiveSupport::MessageEncryptor.new(Rails.application.credentials.secret_key_base.byteslice(0..31))
      token = crypt.encrypt_and_sign("user-id:#{user.id}")

      context[:session][:token] = token
      { user: user, token: token }
    end
  end
end
