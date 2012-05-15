require 'spork'

Spork.prefork do
  puts 'preforking Spork'
  
  require "rails/mongoid"
  Spork.trap_class_method(Rails::Mongoid, :load_models)
  
  require "rails/application"
  Spork.trap_method(Rails::Application, :reload_routes!)
    
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'shoulda/matchers/integrations/rspec'
  
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
end

Spork.each_run do
  FactoryGirl.reload
  
  RSpec.configure do |config|
    config.mock_with :rspec
    config.include Mongoid::Matchers
    
    require 'database_cleaner'
    config.before(:suite) do
      DatabaseCleaner.strategy = :truncation
      DatabaseCleaner.orm = "mongoid"
    end
    
    Dir["#{Rails.root}/app/models/**/*.rb"].each do |model|
      load model
    end

    config.before(:each) do
      DatabaseCleaner.clean
    end
  end
end
