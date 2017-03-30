# Census - An Identity Manager

[![security](https://hakiri.io/github/bcgoss/census/master.svg)](https://hakiri.io/github/bcgoss/census/master) [![Dependency Status](https://gemnasium.com/badges/github.com/bcgoss/census.svg)](https://gemnasium.com/github.com/bcgoss/census) [![Code Climate](https://codeclimate.com/github/bcgoss/census/badges/gpa.svg)](https://codeclimate.com/github/bcgoss/census) [![Test Coverage](https://codeclimate.com/github/bcgoss/census/badges/coverage.svg)](https://codeclimate.com/github/bcgoss/census/coverage)
[![Build Status](https://travis-ci.org/bcgoss/census.svg?branch=staging)](https://travis-ci.org/bcgoss/census)

> Census serves as a central location for identity management and authentication across the [Turing School](https://github.com/turingschool) community.

## Table of Contents
- [Onboarding Tips](#onboarding)
  - [Heroku](#heroku)
  - [FAQ](#faq)
- [Requirements](#requirements)
  - [Ruby on Rails](#ror)
  - [Environment Variables](#environment-variables)
  - [Paperclip gem](#paperclip)
- [Installation](#installation)
- [API Endpoints](#api-endpoints)
- [Register an Application](#register)
  - [Gems](#gems)
- [Roles](#roles)
  - [Permissions](#permissions)
  - [Flags](#flags)
- [Maintainer](#maintainer)
    - [Original Contributors](#original-contributors)
- [Contribute](#contribute)
- [License](#license)

## [Onboarding tips](#onboarding)
### [Heroku](#heroku)
* staging: https://census-app-staging.herokuapp.com/
* production: https://turing-census.herokuapp.com/
* Other teams will use the staging app for their staging environment. Switching between environments requires switching the oauth gem. In staging, Gemfile should include:
```
gem 'omniauth-census', git: "https://github.com/nzenitram/census_staging_oauth"
```
In production:
```
gem 'omniauth-census', git: "https://github.com/turingschool-projects/omniauth-census"
```
* There will be two apps connected to the same repository, staging auto deploys from the staging branch, and production auto deploys from master.
* To access the heroku console for a specific app, run `heroku run --app <APP-NAME> console`

### [FAQ](#faq)
* Why can't I authenticate from localhost?
  - Census only allows authentication from a secure connection. This won't be a problem on a Heroku server, but it's a bit of a headache on localhost. In order to test OAuth locally, you need to create an ssl certificate and run a local server "securly." Luckily, Nick Martinez wrote a great [tutorial](https://github.com/NZenitram/census_staging_oauth) to make this work in the "Important Stuff" section of the oauth staging gem.

* What's up with these tokens?
  - Be aware that tokens expire every 90 days. Doorkeeper provides a way to grab a refresh token so your session isn't interupted.

## [Requirements](#requirements)
### [Ruby on Rails](#ror)
```
RAILS VERSION
  - 5.0.0.1

RUBY VERSION
  - 2.3.0p0

BUNDLED WITH
  - 1.13.7
```

### [Environment Variables](#environment-variables)

Census is built to expect a certain number of environment variables. We suggest using something like [Figaro](https://github.com/laserlemon/figaro) to set them securely.

You will need an AWS S3 Bucket, Access Key ID, a Secret Access Key and an AWS region defined. Use the [AWS SDK](https://github.com/aws/aws-sdk-ruby) gem to get started.

Environment Variables:

```yaml
SALT # used for salting email invite tokens. Can be any random string.
MY_EMAIL # used for testing purposes. Can be any email.
S3_BUCKET_NAME # Not needed in development
AWS_ACCESS_KEY_ID # Not needed in development
AWS_SECRET_ACCESS_KEY # Not needed in development
AWS_REGION # Not needed in development
```

### [Paperclip Gem](#paperclip)

Census uses the [Paperclip](https://github.com/thoughtbot/paperclip#ruby-and-rails) gem in order to upload user profile photos. To ensure testing and development works, ImageMagick must be installed and Paperclip must have access to it.

If you're on Mac OS X, you'll want to run the following with Homebrew:

```brew install imagemagick```

## [Installation](#installation)

To install, clone down the project and run the following commands:

```
bundle install
bundle exec rake db:{create,migrate}
```

To run development locally, use the command:
```
rails server
```
## [API Endpoints](#api-endpoints)

To hit the Census API, you need to send an `access_token` as a param. This is the token that you get back with the users credentials during the OAuth handshake. That will look something like `user_credentials['token']` depending on the variable that you use to store the response.

To receive a user by name:
```
GET 'https://census-app-staging/api/v1/users/by_name?q=[NAME]'
```

To receive all users by cohort:
```
GET 'https://census-app-staging/api/v1/users/by_cohort?cohort_id=<ID>'
```
You can use the `api/v1/cohorts` endpoint to find cohort ids.
<br>
<br>
<br>

To receive a user by ID:
```
GET 'https://census-app-staging/api/v1/users/:id'
```

To receive all users:
```
GET 'https://census-app-staging/api/v1/users/'
```

To receive your own user credentials:
```
GET 'https://census-app-staging/api/v1/user_credentials'
```

The user endpoints return JSON in this format:
```
{
  "id": 55,
  "first_name": "Channa",
  "last_name": "Golan",
  "cohort": "1608-BE",
  "image_url": "https://census-app-staging.herokuapp.com/images/original/missing.png",
  "email": "Channa.Golan@example.com",
  "slack": "channa55",
  "twitter": "chanana",
  "linked_in": "channa-golan",
  "git_hub": "golen5000",
  "groups": [],
  "roles": [
    "active student"
  ]
}
```

To receive all cohorts:

```
GET 'https://census-app-staging/api/v1/cohorts'
```

The cohort endpoints return JSON in this format:
```
[{"id"=>30, "name"=>"1608-BE", "created_at"=>"2017-02-23T16:38:39.134Z", "updated_at"=>"2017-02-23T16:38:39.134Z", "status"=>"active"},
 {"id"=>31, "name"=>"1606-FE", "created_at"=>"2017-02-23T16:38:39.145Z", "updated_at"=>"2017-02-23T16:38:39.145Z", "status"=>"finished"}]
```

## [Register an Application](#register)
Census uses [Devise](https://github.com/plataformatec/devise), [Doorkeeper](https://github.com/doorkeeper-gem/doorkeeper) and [cancancan](https://github.com/CanCanCommunity/cancancan) to manage authentication and authorization.

### [Gems](#gems)
Currently, there are 2 gems to help you set up OAuth, one for [staging](https://github.com/NZenitram/census_staging_oauth) and one for [production](https://github.com/turingschool-projects/omniauth-census). Soon, we will add a configuation option so you don't need to change your gemfile before pushing to production.

## [Roles](#roles)
Some roles are just a flag for querying, others define your permissions on the site. Below is a list of all the currently available roles.
<br>
Note that the staging server is messy and roles may be incorrect for some users. Contact an admin if you need to change your permissions.
<br>
Roles are changed according to cohort status. For example, when an active cohort is moved to finished, all the "active student"s in that cohort will be moved to "graduated." "Removed" and "exited" students roles will not be effected.

### [Permissions](#permissions)
* Admin
  - Can crud all aspects of users.
  - Can manage applications

* Staff / Active Student / Graduated / Mentor
  - Can read and update their own personal info.
  - Can join public groups.
  - Can read cohort information (view cohort pages).
  - Can manage applications

* Enrolled
  - Can read and update their own personal info.
  - Can read cohort information (view cohort pages).

* Exited / Removed
  - Can't do anything

### [Flags](#flags)
* Instructor

## [Maintainer](#maintainer)

* Jeff Casimir - [jcasimir](https://github.com/jcasimir)

### [Original Contributors](#original-contributors)

* Jesse Spevack - [PlanetEfficacy](https://github.com/PlanetEfficacy)
* Calaway - [calaway](hhttps://github.com/calaway)
* Bryan Goss - [bcgoss](https://github.com/bcgoss)
* Jasmin Hudacsek - [j-sm-n](https://github.com/j-sm-n)

## [Contribute](#contribute)
`TODO:` Add a CONTRIBUTING.md

## [License](#license)
`TODO:` Add a license.md
