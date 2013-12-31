# Memorizr

[![Build Status](https://travis-ci.org/suhrawardi/memorizr.png?branch=master)](https://travis-ci.org/suhrawardi/memorizr) [![Code Climate](https://codeclimate.com/github/suhrawardi/memorizr.png)](https://codeclimate.com/github/suhrawardi/memorizr) [![Coverage Status](https://coveralls.io/repos/suhrawardi/memorizr/badge.png)](https://coveralls.io/r/suhrawardi/memorizr)

A simple and basic application you can use to archive and discuss quotes, notes and attachments.

## Install

The Capistrano tasks to start the server use Monit. There are countless other ways run Rails, and this might not be the best one. So be creative, add other ways, and send me a pull request... :-))

For the rest, just deploy it like any other Rails app, but:

#### Config files

Make sure to create the following config files in the shared directory on the server:

  1. config/database.yml
  2. config/settings.yml

See the examples in the config directory.

#### Capistrano files

Add the following capistrano files in the Memorizr clone on your local machine:

  1. config/deploy/custom.rb
  2. config/deploy/production.rb

#### Deploy

Something along the lines of:

    $ cap deploy:setup
    $ cap deploy:update_code

And load the correct database structure (in the current directory on the server):

    $ bundle exec rake load:schema

And create an admin user (on the server). This user is the first one to log in, and can invite other users:

    $ bundle exec rails c production

    1.9.3p484 :001 > User.create!(name: 'name', email: 'email', password: 'pw', password_confirmation: 'pw', admin: true)


## License

Memorizr is released under the [MIT License](http://www.opensource.org/licenses/MIT).
