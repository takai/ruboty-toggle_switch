# Ruboty::ToggleSwitch

[![Build Status](https://travis-ci.org/takai/ruboty-toggle_switch.svg?branch=master)](https://travis-ci.org/takai/ruboty-toggle_switch)

ruboty-toggle_switch allows you to toggle switch on/off.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruboty-toggle_switch'
```

## Usage

```
> ruboty: toggle switch on
switch is now on.
> ruboty: show switch status
switch is on on Apr 27 at 06:29.
> ruboty: toggle switch off for good sleeping
switch is now off.
> ruboty: show switch status
switch is off for good sleeping on Apr 27 at 06:30.
```

## API

Use `Ruboty::ToggleSwitch::Storage` to get the state of switch from another handlers:

```ruby
storage = Ruboty::ToggleSwitch::Storage.new(robot.brain)
record  = storage['switch']
record.status # => 'on' or 'off'
```
