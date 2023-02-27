# frozen_string_literal: true

if ENV['COV']
  require 'simplecov'
  SimpleCov.start('rails') do
    add_group 'Services', 'app/services'
  end
end
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.before(:suite) do
    config.render_views
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :deletion, { except: 'spatial_ref_sys' }
    DatabaseCleaner.clean_with :truncation, { except: 'spatial_ref_sys' }

    DatabaseCleaner.start
    DatabaseCleaner.clean
  end
end
