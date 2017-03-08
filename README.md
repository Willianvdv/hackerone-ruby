# Hackerone Ruby Bindings

HackerOne resources in your Ruby app. This is an experiment, don't use it.

## Installation

There are no installation instructions yet.

## Usage

To get an user from HackerOne you can do:
```lang=ruby
irb(main):002:0> Hackerone::User.find_by(username: 'wvdv')
=> #<Hackerone::User name="Willian", username="wvdv", signal=nil, reputation=102, impact=nil>
```

To get a team from HackerOne you can do:
```lang=ruby
irb(main):002:0> Hackerone::Team.find_by(handle: 'security')
=> #<Hackerone::Team handle="security", name="HackerOne">
```
