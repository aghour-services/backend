# frozen_string_literal: true

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
    DatabaseCleaner.strategy = :deletion, { except: 'spatial_ref_sys' }
    DatabaseCleaner.clean_with :truncation, { except: 'spatial_ref_sys' }

    DatabaseCleaner.start
    DatabaseCleaner.clean
    load Rails.root.join('db', 'seeds.rb')
  end
end
