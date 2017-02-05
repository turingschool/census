# Census - An Identity Manager

[![security](https://hakiri.io/github/bcgoss/census/master.svg)](https://hakiri.io/github/bcgoss/census/master) [![Dependency Status](https://gemnasium.com/badges/github.com/bcgoss/census.svg)](https://gemnasium.com/github.com/bcgoss/census) [![Code Climate](https://codeclimate.com/github/bcgoss/census/badges/gpa.svg)](https://codeclimate.com/github/bcgoss/census) [![Test Coverage](https://codeclimate.com/github/bcgoss/census/badges/coverage.svg)](https://codeclimate.com/github/bcgoss/census/coverage)
[![Build Status](https://travis-ci.org/bcgoss/census.svg?branch=staging)](https://travis-ci.org/bcgoss/census)

> Census serves as a central location for identity management and authentication across the [Turing School](https://github.com/turingschool) community.

## Table of Contents

- [Requirements](#requirements)
  - [Ruby on Rails](#ror)
  - [Environment Variables](#environment-variables)
  - [Paperclip gem](#paperclip)
- [Installation](#installation)
- [API Endpoints](#api-endpoints)
- [Maintainer](#maintainer)
    - [Original Contributors](#original-contributors)
- [Contribute](#contribute)
- [License](#license)

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
```
SALT # used for salting email invite tokens
MY_EMAIL # used for testing purposes. Can be any email.
S3_BUCKET_NAME
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
AWS_REGION
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

To receive a user by name:
```
GET 'https://login.turing.io/api/v1/users/by_name?q=[NAME]'
```

To receive a user by ID:
```
GET 'https://login.turing.io/api/v1/users/:id'
```

To receive all users:
```
GET 'https://login.turing.io/api/v1/users/'
```

To receive your own user credentials:
```
GET 'https://login.turing.io/api/v1/user_credentials'
```

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
