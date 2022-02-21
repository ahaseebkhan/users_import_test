# Test Project

## Description
* This project imports user data (name, password) and stores them in the database.
* Validations are added to check password strength and name
* After submitting the csv, output shows how many characters need to change in order to make the password valid if its not.

## System dependencies
* Ruby 3.1.1
* PostgreSQL

## Installation and Local Setup
* Run `bundle install`
* Add `RAILS_MASTER_KEY` to `config/master.key` which is used to decrypt the `config/credentials.yml.enc`
* Add development and test environment keys to `config/credentials/development.key` and `config/credentials/test.key` respectively. We have separate credential files for test and development environments.
* Run `rake db:create db:migrate db:seed`
* To start the project run `rails s`

## Password validation logic
* Each creation, replacement and removal is counted as a separate change
* Addition, removal or replacement can be done anywhere inside the string

## Password validation examples
* For `Helloworl` a digit is missing and length is less by 1 character. So here we will just add a digit at the end only 1 change is required.
* For `ooooooo` a digit and lower case case characters are missing. With that the length is less by 1 and there is a repetition as well. So to handle this we can add 3 characters after every 2 `o`s. Something like `oo1ooAoob` which required a total of 3 minimum changes.

## Future improvements
* Add validations to not support very large files or process them in background
* Add capybara and cucumber for feature tests
