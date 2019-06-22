# Guide

- Setup Gemfile
  1. Check `Gemfile`
  
- Use PostgreSQL
  
  1. Paste `gem 'pg', '~> 0.18.4'` to `Gemfile` 
  1. Setup `database.yml`
  1. Run `$ bundle install`
   
- Use `dotenv`
  
  1. Paste `gem 'dotenv', '~> 2.7', '>= 2.7.2'` to Gemfile
  2. Create a `.env` file by running `$ touch .env` in your terminal
  3. Run `$ bundle install`

- Create a Procfile

  1. In your terminal, run `$ touch Procfile`
  1. Paste `web: bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-development}` to the `Porcfile` you just created.
  1. Paste the following code to your `.env` file:
      
      ```
      RACK_ENV=development
      PORT=3000
      ````
  1. Add `.env` to your `.gitignore` file
  1. Create another file called `.env_example` by running `touch .env_example` in your terminal 

- RSpec for Test
  
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

- Rubocop:
  
  - Add this line `gem 'rubocop-rails', '~> 2.0', '>= 2.0.1'` to the `group :development, :test` block
  - Run `$ rubocop --auto-gen-config` in terminal to create a `.rubocop_todo.yml`

- Deploy to Heroku
  `https://devcenter.heroku.com/articles/getting-started-with-rails5`

-


- Useful commands

  1. `$ bundle exec rspec`
  2. `$ bundle exec rubocop`
