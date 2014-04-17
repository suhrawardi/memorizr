# Memorizr

[![Build Status](https://travis-ci.org/suhrawardi/memorizr.png?branch=master)](https://travis-ci.org/suhrawardi/memorizr) [![Code Climate](https://codeclimate.com/github/suhrawardi/memorizr.png)](https://codeclimate.com/github/suhrawardi/memorizr) [![Coverage Status](https://coveralls.io/repos/suhrawardi/memorizr/badge.png)](https://coveralls.io/r/suhrawardi/memorizr) [![Dependency Status](https://gemnasium.com/suhrawardi/memorizr.png)](https://gemnasium.com/suhrawardi/memorizr)

A basic online collaboration tool for discussing and archiving quotes, notes and attachments.

## Introduction

As a logged in user, you can:

* Add quotes: parts of other websites.
* Add notes: texts you write yourself.
* Add attachments: images or other files.
* Invite other users.
* Add comments to other quotes, notes or attachments.

#### How to add a quote?

Once logged in, you see a link "bookmark" in the top menu. Drag that link to your bookmarks. Select a part of any other webpage, and click on the bookmark. The selected content is posted as a quote to the application.

You can edit an existing quote by removing parts of the content and by highlighting words in the content.

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

## Installation on Heroku

You need to have a config/settings.yml file commited in the Git repo to
run Memorizr on Heroku:

    $ git checkout -b heroku
    $ git add -f config/settings.yml
    $ git commit -m 'Added a config/settings.yml file for Heroku'
    $ git push heroku heroku:master
    $ git checkout master # to return to the master branch

And then after you made changes:

    $ git checkout heroku
    $ git rebase master
    $ git push heroku heroku:master

## Contributing to Memorizr

See [CONTRIBUTING.md](https://github.com/suhrawardi/memorizr/blob/master/CONTRIBUTING.md)

## License

Copyright (c) 2010-2014 Jarra Schirris

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
