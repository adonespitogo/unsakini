
# Full-Stack Installation

Create a new rails application named `my-app` or anything you like.
```
$ rails new my-app
$ cd my-app
```
Add the gem to your `Gemfile`.
```
gem 'unsakini'
```
Bundle install and initialize the application
```
$ bundle install
$ rake unsakini:install
```
The `rake unsakini:install` command is just a super set of the following commands:
```
$ rails generate unsakini:config              # generates config/initializers/unsakini.rb
$ rails generate unsakini:dependencies        # add dependencies to Gemfile
$ rake unsakini_engine:install:migrations     # copy the engine migrations to db/migrations directory
$ rake db:migrate                             # runs the migration files
```

These dependencies will be added to your Gemfile
```bash
gem "active_model_serializers"
gem "rack-cors"
gem "kaminari"
gem "api-pagination"
# As of Nov 28, 2016: waiting for my PR to be merged
# https://github.com/nsarno/knock/pull/126
gem 'knock', git: 'https://github.com/adonespitogo/knock'

```

Install the newly added dependencies

**Note:** You might want to review your Gemfile first
```
$ bundle install
```

Run local rails server
```
$ rails s
```

At this point, you have a working Unsakini API in your local machine. Next thing to do is install the client. Read the instructions on how to install and configure the client [here](./CLIENT.md).

After installing the client. You can now deploy your rails application.