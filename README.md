# VisibilityMonitor

Provides a way to monitor a module for method visibility changes with MRI ruby.

This might be useful when using Module#method_added to detect method
definitions where the visibility of the method is also of interest.
The problem is that the method visibility might be changed immediately
after the method is defined (e.g. when using `private def` to define
a private method).

Although the visibility methods (private, protected and public) can
be overridden in pure ruby code to detect visibility changes,
calling `super` doesn't change the visibility scope when the visibility
method is called without arguments (e.g. `private`). This gem works
around this limitation by overriding these visibility methods in a C
extension, so they don't interfere with setting the visibility scope.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'visibility_monitor'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install visibility_monitor

## Usage

To monitor a module for method visibility changes, extend it with
VisibilityMonitor, then the visibility_set class method will be
called after a method's visibilty is set. For example

```ruby
require 'visibility_monitor'

class Example
  extend VisibilityMonitor

  def self.visibility_set(method_name, visibility_symbol)
    puts "method :#{method_name} has been marked :#{visibility_symbol}"
  end

  private def example
  end
end
```

would output

```
method :example has been marked :private
```


## Development

After checking out the repo, run `bin/setup` to install dependencies.
Then, run `rake test` to run the tests. You can also run `bin/console`
for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake
install`. To release a new version, update the version number in
`version.rb`, and then run `bundle exec rake release`, which will
create a git tag for the version, push git commits and tags, and
push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/dylanahsmith/visibility_monitor.

## License

The gem is available as open source under the terms of the [MIT
License](https://opensource.org/licenses/MIT).
