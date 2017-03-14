# Hackerone Ruby Bindings

HackerOne resources in your Ruby app. This is an experiment, don't use it.

## Installation

There are no installation instructions yet.

## Usage

To get an user from HackerOne you can do:
```lang=ruby
irb(main):001:0> Hackerone::User.find_by(username: 'wvdv')
=> #<Hackerone::User>
```

To get a team from HackerOne you can do:
```lang=ruby
irb(main):001:0> Hackerone::Team.find_by(handle: 'security')
=> #<Hackerone::Team>
```

Fetch a published report
```lang=ruby
irb(main):001:0> Hackerone::Report.find_by(id: 192127)
=> #<Hackerone::Report>
```
