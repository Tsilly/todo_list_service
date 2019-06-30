# TODO

- [ ] Create user
- [ ] Create, update todo_list
- [ ] Create, update todo_item
- [ ] Add CORS to Guide


# Guide

## Setup Gemfile
  - Check `Gemfile`, remove gems you're not going to use.
  
## Use PostgreSQL
  
  - Paste `gem 'pg', '~> 0.18.4'` to `Gemfile` 
  - Setup `database.yml`
  - Run `$ bundle install`
   
## Use `dotenv`
  
  - Paste `gem 'dotenv', '~> 2.7', '>= 2.7.2'` to Gemfile
  - Create a `.env` file by running `$ touch .env` in your 1erminal
  - Run `$ bundle install`

## Create a Procfile

  - In your terminal, run `$ touch Procfile`
  - Paste `web: bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-development}` to the `Porcfile` you just created.
  - Paste the following code to your `.env` file:
      
      ```
      RACK_ENV=development
      PORT=3000
      ````
  - Add `.env` to your `.gitignore` file
  - Create another file called `.env_example` by running `touch .env_example` in your terminal 

## Test
  
### Rspec

  -  Add the following gems to your `Gemfile`

      ```
      group :development, :test do
        gem 'rspec-rails', '~> 3.8', '>= 3.8.2'
        gem 'shoulda-matchers', '~> 4.1'
      end
      ```
  - Remove `test/` folder by running `$ rm -rf test` in the terminal.
  - Run `$ bundle install`
  - Run `$ rails generate rspec:install`
  - Change the setup for rspec. Check `spec/rails_helper.rb` and `spec/rails_helper.rb`

### Prepare fake data

  - Add these 2 gems to Gemfile

      ```
      group :development, :test do
        gem 'factory_bot_rails', '~> 5.0', '>= 5.0.2'
        gem 'faker', '~> 1.9', '>= 1.9.4'
      end
      ```
  - Run `$ bundle install`
  - Open `rails_helper.rb`, and add the following line:
    ```
    RSpec.configure do |config|
      ...
      config.include FactoryBot::Syntax::Methods
      ...
    end
    ```


## Rubocop:
  
  - Add the `rubocop-rails` to your Gemfile, and run `$ bundle install`
      ```
      ...
      group :development, :test do
        gem 'rubocop-rails', '~> 2.0', '>= 2.0.1'
      end
      ...
      ```

  - Run `$ rubocop --auto-gen-config` in terminal to create a `.rubocop_todo.yml`

## Deploy to Heroku
  - Check this guide: `https://devcenter.heroku.com/articles/getting-started-with-rails5`

  - If you see the following error while deploying to heroku

    ```
    You must use Bundler 2 or greater with this lockfile.
    ```
    You can set your Heroku app to use that buildpack, by running `$ heroku buildpacks:set https://github.com/bundler/heroku-buildpack-bundler2` in terminal. (ref: https://github.com/bundler/bundler/issues/6784)

## Add models
  - We need 2 models `todo_list` and `todo_item`:
  - In terminal, run 
    ```
    $ rails g model todo_list user:belongs_to title:string description:text
    $ rails g model todo_item todo_list:belongs_to content:string completed_at:datetime todo_list_id:integer:index

    ```
  - Setup factories for `todo_lists` and `todo_items`. (Check examples: `spec/factories/todo_items.rb` and `spec/factories/todo_lists.rb`

## GraphQL

### Setup
  - In your Gemfile, add 2 gems:

    ```
    ...
    gem 'graphql', '~> 1.9', '>= 1.9.6'
    group :development do
      gem 'graphiql-rails'
    end
    ...

    ```

  - Run `$ bundle install`
  - Run the generator: `$ rails generate graphql:install`
  - Open `application.rb`, and uncomment the following line:
    ```
    require "sprockets/railtie"
    ```
  - Open http://localhost:3000/graphiql in your browser. It's the IDE for you to try some query

### Generate GraphQL files
  ```
  $ rails generate graphql:object user
  $ rails generate graphql:object todo_list
  $ rails generate graphql:object todo_item
  ```

### User FactoryBot and Fake to create a fake user:
  - Example can be found in `spec/factories/user_factory.rb`
  - Start rails console by running `$ rails c` in the terminal:
  - In the console, run `$ FactoryBot.create(:user)`
  - In the GraphQL IDE, run this query:
    ```
    query {
      users {
        email
      }
    }
    ```

### Query users with todo_lists and todo_items
  - Create some fake users with todo_lists and todo_items:
  - In the GraphQL IDE, run this query:

  ```
  query {
    users {
      id
      email
      todoLists {
        title
        description
        todoItems {
          content
          createdAt
          completedAt
        }
      }
    }
  }
  ```

### Query single user with todolists

  ```
  query user {
    user(id: 1) {
      name
      email
      todoLists {
        title
      }
    }
  }
  ```

### Create User
  - Set mutation: `app/graphql/mutations/create_todo_list.rb`
  - Add the `Mutations::CreateUser` to **MutationType** (`app/graphql/types/mutation_type.rb`):
    ```
      class MutationType < Types::BaseObject
        ...
        field :create_user, mutation: Mutations::CreateUser
        ...
      end
    ```

  In GraphQL IDE, run:

  ```
    mutation {
      createUser (
        input: {
          name: "user1",
          authAttributes: {
            email: "user1@example.com",
            password: "password"
          }
        }
      ) {
        user {
          id
          name
          emal
        }
      }  
    }
  ```

  The right panel will return the `id`, `name`, and `email` of the user you just created.

### Signin
  - Create a mutation for **SignInUser**: `app/graphql/mutations/sign_in_user.rb`
  - Add the follow code to **GraphqlController** (`app/controllers/graphql_controller.rb`)

  ```
    class GraphqlController < ApplicationController
      def execute
        ...

        context = {
          session: session,
          current_user: current_user
        }
        ...
      end

      ...

      private

      def current_user
        return unless session[:token]

        crypt = ActiveSupport::MessageEncryptor.new(Rails.application.credentials.secret_key_base.byteslice(0..31))
        token = crypt.decrypt_and_verify session[:token]
        user_id = token.gsub('user-id:', '').to_i
        User.find_by id: user_id
      rescue ActiveSupport::MessageVerifier::InvalidSignature
        nil
      end
      ...
    end
  ```

  - In GraphQL IDE, run

  ```
  mutation signInUser {
    signInUser (
      input: {
        authAttributes: {
          email: "user1@example.com",
          password: "password"
        }
      }
    ) {
      user {
        name
        email
      }
      token
    }  
  }
  ```
  The right panel should show the `user object` and `token`.


### Create TodoList associated to the current user
  - Add a **CreateTodoList** class, e.g. `app/graphql/mutations/create_todo_list.rb`
  - Add **Mutations::CreateTodoList** to the **MutationType**

  ```
  module Types
    class MutationType < Types::BaseObject
      ...
      field :create_todo_list, mutation: Mutations::CreateTodoList
      ...
    end
  end

  ```
  - run mutation `signInUser` 
  - run mutation `createTodoList`


### Create TodoItem
  _[...coming soon]_

### React
  _ref: https://medium.com/@taylorwu/learning-graphql-with-rails-5f44b1aac0db_


## (Deprecated) Devise (Deprecated)

  _Note: This project does not use devise anymore._

### Setup
  - Put `gem 'devise', '~> 4.6', '>= 4.6.2'` to your gemfile, and run `$ bundle install`
  - Run the generator: `$ rails generate devise:install`
  - Generate an User model: `$ rails generate devise User`
  - Run migration: `$rails db:migrate`
  - Open `app/controllers/application_controller.rb` and insert this line: `before_action :authenticate_user!`

### Controller test with devise
  Ref: https://github.com/plataformatec/devise/wiki/How-To:-Test-controllers-with-Rails-(and-RSpec) 

## Useful commands

  ```
  $ bundle exec rspec
  $ bundle exec rubocop
  $ git push heroku master # Push commits to heroku master branch
  $ heroku open # Open your app hosted on heroku
  $ heroku logs # Check logs
  ```
