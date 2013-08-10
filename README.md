# Fluctus
[![Code Climate](https://codeclimate.com/github/APTrust/fluctus.png)](https://codeclimate.com/github/APTrust/fluctus)
[![Dependency Status](https://gemnasium.com/APTrust/fluctus.png)](https://gemnasium.com/APTrust/fluctus)
[![Coverage Status](https://coveralls.io/repos/APTrust/fluctus/badge.png)](https://coveralls.io/r/APTrust/fluctus)

## APTrust Admin Console (Hydra Head)

This application aims to use the entire Hydra stack to manage all APTrust interactions with Fedora.  

### Requirements
* Ruby 2.0.0
* Rails 4.0.0
* hydra-head 6.3.2

## Setup Instructions
* Setup APTrust Institution object

````
# Write institution to variable for use later
i = Institution.create!(name: "APTrust")
````

* Setup Fluctus Roles

````
['admin', 'institutional_admin', 'institutional_user'].each do |role|
  Role.create!(name: role)
end
````

      
* Setup First User Account with <strong>your</strong> Google Email.

````
User.create!(name: <your name>, email: <your Google Email>, phone_number: <Your phone number>, institution_name: i.name, role_ids: [Role.first.id])
````

## Heroku Instructions
[Fluctus on Heroku](http://fluctus.herokuapp.com)

Your Google email address must be added to the DB on heroku by APTrust staff, so contact them if you need to be added.  Otherwise, you will not be an authorized user and will be denied total access to the application.

### Developers
To setup your own Heroku hosted version:

* Push latest version of master

````
git push heroku master
````
* Update database to ensure DB is up to date.

````
heroku run rake db:migrate
````
* Ensure configuration parameters are up to date on Heroku.  config/application.yml must be present in your local app and have your secret configuration parameters.

````
rake figaro:heroku
````
* Restart application

````
heroku restart
````
* Open application

````
heroku open
````
* Follow setup instructions as above.