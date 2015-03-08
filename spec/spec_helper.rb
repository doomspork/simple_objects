ENV['RACK_ENV'] = 'test'

require 'coveralls'
require 'simplecov'
require 'rspec/its'

SimpleCov.formatters = [SimpleCov::Formatter::HTMLFormatter, Coveralls::SimpleCov::Formatter]

SimpleCov.start do
  add_filter 'spec'
  coverage_dir 'docs/coverage'
end

require 'simple_objects'

Dir['spec/support/**/*.rb'].each { |f| require f }

RSpec.configure do |config|
  config.pattern = '**/*_spec.rb'
  config.mock_framework = :rspec
end
