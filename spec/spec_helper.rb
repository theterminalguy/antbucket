require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start
require 'coveralls'
require 'simplecov'
Coveralls.wear!
SimpleCov.start

require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'

Dir[::Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    config.raise_errors_for_deprecations!
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.include Request::JsonHelpers, type: :controller
  config.include ApiControllerHelper, type: :controller
  config.include FactoryGirl::Syntax::Methods
end
