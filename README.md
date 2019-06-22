# Guide

## Setup Gemfile
  - Check `Gemfile`, remove gems you're not ging to use.
  
## Use PostgreSQL
  
  1. Paste `gem 'pg', '~> 0.18.4'` to `Gemfile` 
  2. Setup `database.yml`
  3. Run `$ bundle install`
   ## Use `dotenv`
  
  4. Paste `gem 'dotenv', '~> 2.7', '>= 2.7.2'` to Gemfile
  5. Create a `.env` file by running `$ touch .env` in your 1erminal
  6. Run `$ bundle install`

## Create a Procfile

  1. In your terminal, run `$ touch Procfile`
  1. Paste `web: bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-development}` to the `Porcfile` you just created.
  1. Paste the following code to your `.env` file:
      
      ```
      RACK_ENV=development
      PORT=3000
      ````
  1. Add `.env` to your `.gitignore` file
  1. Create another file called `.env_example` by running `touch .env_example` in your terminal 

## Test
  
### Rspec

  1. Add the following gems to your `Gemfile`

      ```
      group :development, :test do
        gem 'rspec-rails', '~> 3.8', '>= 3.8.2'
        gem 'shoulda-matchers', '~> 4.1'
      end
      ```
  1. Remove `test/` folder by running `$ rm -rf test` in the terminal.
  1. Run `$ bundle install`
  1. Run `$ rails generate rspec:install`
  1. Change the setup for rspec. Check `spec/rails_helper.rb` and `spec/rails_helper.rb`

### Prepare fake data

  1. Add these 2 gems to Gemfile

      ```
      group :development, :test do
        gem 'factory_bot_rails', '~> 5.0', '>= 5.0.2'
        gem 'faker', '~> 1.9', '>= 1.9.4'
      end
      ```
  2. Run `$ bundle install`


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


## GraphQL
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


## Devise
  1. Put `gem 'devise', '~> 4.6', '>= 4.6.2'` to your gemfile, and run `$ bundle install`
  2. Run the generator: `$ rails generate devise:install`
  3. Generate an User model: `$ rails generate devise User`
  4. Run migration: `$rails db:migrate`
  5. Open `app/controllers/application_controller.rb` and insert this line: `before_action :authenticate_user!`

## 

## Useful commands

  ```
  $ bundle exec rspec
  $ bundle exec rubocop
  $ git push heroku master # Push commits to heroku master branch
  $ heroku open # Open your app hosted on heroku
  $ heroku logs # Check logs
  ```
