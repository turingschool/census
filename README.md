# Census - An Identity Manager

[![Code Climate](https://codeclimate.com/github/bcgoss/census/badges/gpa.svg)](https://codeclimate.com/github/bcgoss/census) [![Test Coverage](https://codeclimate.com/github/bcgoss/census/badges/coverage.svg)](https://codeclimate.com/github/bcgoss/census/coverage)
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
* staging: census-app-staging and login-staging.turing.io
* production: turing-census and login.turing.io
* Other teams will use the staging app for their staging environment. Switching
  between environments requires configuring the oauth gem oauth endpoint.
  Install the gem via:

```
gem 'omniauth-census', git: "https://github.com/turingschool-projects/omniauth-census"
```

* There will be two apps connected to the same repository, staging auto deploys from the staging branch, and production auto deploys from master.

### [FAQ](#faq)
* What's up with these tokens?
  - Be aware that app specific tokens expire every 90 days. Doorkeeper provides
    a way to grab a refresh token so your session isn't interupted. If your app
    requires programatic access on behalf of the app (as opposed to on behalf of a
    specific user) token refresh logic will need to be included.

## [Requirements](#requirements)
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

Census uses the
[Paperclip](https://github.com/thoughtbot/paperclip#ruby-and-rails) gem in
order to upload user profile photos. To ensure testing and development works,
ImageMagick must be installed and Paperclip must have access to it.

If you're on Mac OS X, you'll want to run the following with Homebrew:

`brew install imagemagick`

### Other services
Census depends on Enroll's API to fetch Cohort data. This access is performed
via a GraphQL client pointed at `ENROLL_GRAPHQL_ENDPOINT` (defaulted to having
Enroll running on `localhost:3001` and authorized via the `API_AUTH_SECRET` env
var. Census tests mock out this dependency.

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

To get some helpful user accounts to play around in development:

```
bundle exec rake db:seed
```

This will create the following users, all with the password `password`:

- An Admin user with the email `admin@example.com`
- A Student with an email of `j.s@example.com`
- A Student with an email of `a.s@example.com`
- A Student with an email of `b.g@example.com`

More info in [seeds.rb](./db/seeds.rb)

## [API Endpoints](#api-endpoints)

To hit the Census API, you need to send an `access_token` as a param. This is the token that you get back with the users credentials during the OAuth handshake. That will look something like `user_credentials['token']` depending on the variable that you use to store the response.

To receive a user by name:
```
GET 'https://census-app-staging.herokuapp.com/api/v1/users/by_name?q=[NAME]'
```

To receive all users by cohort:
```
GET 'https://census-app-staging.herokuapp.com/api/v1/users/by_cohort?cohort_id=<ID>'
```
You can use the `api/v1/cohorts` endpoint to find cohort ids.
<br>
<br>
<br>

To receive a user by ID:
```
GET 'https://census-app-staging.herokuapp.com/api/v1/users/:id'
```

To receive all users:
```
GET 'https://census-app-staging.herokuapp.com/api/v1/users/'
```

To receive your own user credentials:
```
GET 'https://census-app-staging.herokuapp.com/api/v1/user_credentials'
```

To receive a user's credentials by github username:
```
GET 'https://census-app-staging.herokuapp.com/api/v1/find_by_github?q=github_username'
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
GET 'https://census-app-staging.herokuapp.com/api/v1/cohorts'
```

The cohort endpoints return JSON in this format:
```
[{"id"=>30, "name"=>"1608-BE", "created_at"=>"2017-02-23T16:38:39.134Z", "updated_at"=>"2017-02-23T16:38:39.134Z", "status"=>"active"},
 {"id"=>31, "name"=>"1606-FE", "created_at"=>"2017-02-23T16:38:39.145Z", "updated_at"=>"2017-02-23T16:38:39.145Z", "status"=>"finished"}]
```

## [Register an Application](#register)
Census uses [Devise](https://github.com/plataformatec/devise), [Doorkeeper](https://github.com/doorkeeper-gem/doorkeeper) and [cancancan](https://github.com/CanCanCommunity/cancancan) to manage authentication and authorization.

To Get a token, register your app through Census and then make a request:

Source [here.](https://github.com/doorkeeper-gem/doorkeeper/wiki/Client-Credentials-flow)

Developers can use any HTTP library to make the request (such as [Faraday](https://github.com/lostisland/faraday))

```ruby
conn.post do |req|
  req.url '/oauth/token'
  req.params['grant_type'] = 'client_credentials'
  req.params['client_id'] = ENV['CENSUS_CLIENT_ID'] #=> provided by census interface
  req.params['client_secret'] = ENV['CENSUS_SECRET_ID'] #=> provided by census interface
end
```

This request will generate a token for your application.

### [Gems](#gems)
[`omniauth-census`](https://github.com/turingschool-projects/omniauth-census)
can be used to configure oauth in application. See its README for instructions
on how to use it against different Census environments.

## [Roles](#roles)
Some roles are just a flag for querying, others define your permissions on the
site. Below is a list of all the currently available roles.
<br>
Note that the staging server is messy and roles may be incorrect for some
users. Contact an admin if you need to change your permissions.
<br>
Roles are changed according to cohort status. For example, when an active
cohort is moved to finished, all the "active student"s in that cohort will be
moved to "graduated." "Removed" and "exited" students roles will not be
effected.

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

* Ali Schlereth - [AliSchlereth](https://github.com/AliSchlereth)


## [Contribute](#contribute)
`TODO:` Add a CONTRIBUTING.md

## [License](#license)

Census is released under the [MIT License](http://www.opensource.org/licenses/MIT).
