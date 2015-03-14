# SimpleObjects

Simple objects for Ruby

[![Gem Version](https://badge.fury.io/rb/simple_objects.png)](https://rubygems.org/gems/simple_objects) [![Build Status](https://travis-ci.org/doomspork/simple_objects.svg?branch=master)](https://travis-ci.org/doomspork/simple_objects) [![Code Climate](https://codeclimate.com/github/doomspork/simple_objects/badges/gpa.svg)](https://codeclimate.com/github/doomspork/simple_objects) [![Coverage Status](https://coveralls.io/repos/doomspork/simple_objects/badge.png?branch=master)](https://coveralls.io/r/doomspork/simple_objects?branch=master) [![Dependency Status](https://gemnasium.com/doomspork/simple_objects.svg)](https://gemnasium.com/doomspork/simple_objects)

## Installation

Add this line to your application's Gemfile:

	gem 'simple_objects'

And require it:

	require 'simple_objects'

## Usage

```ruby
class SuperHero
	include SimpleObjects::Base
	
	attribute :name, required: true, type: String
	attribute :power, required: true, type: String
	attribute :age, type: Numeric
end

SuperHero.new(name: 'Superman', power: 'Super stuff', age: 34)

SuperHero.new(name: 'Spiderman', age: 20) #=> raises RequiredMissingError

SuperHero.new(name: 'Spiderman', power: {}) #=> raises MismatchedTypeError
```

## Contributing

Feedback and fixes are always welcome.  Please make use of [Issues](https://github.com/doomspork/simple_objects/issues) and [Pull Requests](https://github.com/doomspork/simple_objects/pulls), all code should have test coverage.

## Author/Contact

SimpleObjects is written and maintained by [@doomspork](http://github.com/doomspork).

## License

SimpleObjects is made available under the [MIT](http://opensource.org/licenses/MIT) License.
