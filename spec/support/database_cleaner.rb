# Database cleaner config
RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with(:trucation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true ) do
    DatabaseCleaner.strategy = :trucation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
