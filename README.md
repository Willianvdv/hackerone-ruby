# Hackerone Ruby Bindings

HackerOne resources in your Ruby app. This is an experiment, don't use it.

## Installation

There are no installation instructions yet.

## Usage

To get an user from HackerOne you can do:
```lang=ruby
::HackerOne::User.find_by(username: 'wvdv')
```

To get a team from HackerOne you can do:
```lang=ruby
::HackerOne::Team.find_by(handle: 'security')
```


