# Guide

## Setup Gemfile
  - Check `Gemfile`, remove gems you're not ging to use.

## User Bundler -v 1.17.3
  1. In terminal, run `$ gem install bundler -v 1.17.3`
  1. In your `Gemfile.lock`, scroll down to the bottom and change the bundler version
      ```
      BUNDLED WITH
      1.17.3
      ```
  
## Use PostgreSQL
  
  1. Paste `gem 'pg', '~> 0.18.4'` to `Gemfile` 
  2. Setup `database.yml`
  3. Run `$ bundle install`
   ## Use `dotenv`
  
  4. Paste `gem 'dotenv', '~> 2.7', '>= 2.7.2'` to Gemfile
  5. Create a `.env` file by running `$ touch .env` in your terminal
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

## RSpec for Test
  
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

## Rubocop:
  
  - Add this line `gem 'rubocop-rails', '~> 2.0', '>= 2.0.1'` to the `group :development, :test` block
  - Run `$ rubocop --auto-gen-config` in terminal to create a `.rubocop_todo.yml`

## Deploy to Heroku
  `https://devcenter.heroku.com/articles/getting-started-with-rails5`


## Useful commands

  ```
  $ bundle exec rspec
  $ bundle exec rubocop
  $ git push heroku master # Push commits to heroku
  ```
