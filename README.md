rgatl-todo-list Milestone 4
============================

This application is a (little less) basic to-do list!

To get this app up and running, run these commands in console:

```bash
bundle install
```
```bash
rake db:create:all
```
```bash
rake db:migrate
```
```bash
rake db:test:prepare
```

These commands do the following:
  1. Install all of the necessary gems listed in the Gemfile
  2. Create the test and development databases based on the configuration specified in config/database.yml
  3. Add all of the tables and table attributes to the development database defined in the migration files in db/migrate
  4. Add all of the tables and table attributes to the test database

Then, to run the tests, run this command in console:
```bash
rspec spec
```


Milestone 2 Additions
---------------------
1. Adds users using the gem devise to the application that are able to maintain separate to-do lists. [Here is a great tutorial](http://guides.railsgirls.com/devise/), but the [documentation on the gem's README](https://github.com/plataformatec/devise) is great too.

Milestone 3 Additions and Changes
---------------------------------

1. Cleans and [DRYs up](http://en.wikipedia.org/wiki/Don't_repeat_yourself) the existing tests.
2. Adds optional deadline field to tasks and displays to user how many days are left to complete the task
3. Adds ability to completely delete lists and tasks

Milestone 4 Additions
---------------------

1. Adds ability to rank and display tasks in priority for a given list
