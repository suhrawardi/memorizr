# Memorizr

A simple and basic application you can use to archive and discuss quotes, notes and attachments.

## Install

The Capistrano tasks to start the server use Monit. There are countless other ways run Rails, and this might not be the best one. So be creative, add other ways, and send me a pull request... :-))

1. Create the database

2. Create a config/deploy/production.rb file (see the config/deploy/production.rb.example file)

3. Run

    $ cap deploy:setup

4. Run

    $ cap deploy:check

5. Create a config/database.yml file in the shared folder. We'll symlink to this one. See config/database.yml.example

6. Run (in the current directory on the server)

    $ bundle exec rake load:schema

7. Create an admin user

    $ bundle exec rails c production

    1.9.3p484 :001 > User.create!(name: 'name', email: 'email', password: 'pw', password_confirmation: 'pw', admin: true)

