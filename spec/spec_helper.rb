# frozen_string_literal: true

%w(analyzers ciphers solvers lib).each do |d|
  $LOAD_PATH << File.join(File.dirname(__FILE__), '..', d)
end

$LOAD_PATH << File.join(File.dirname(__FILE__))

require 'byebug'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end

  config.example_status_persistence_file_path = 'tmp/rspec_examples.txt'
  config.order = :random
end
