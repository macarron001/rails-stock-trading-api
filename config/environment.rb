# Load the Rails application.
require_relative "application"

ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
address: 'smtp.gmail.com',
port: 587,
domain: 'localhost:3001',
user_name: ENV['MAILER_EMAIL'],
password: ENV['MAILER_PASSWORD'],
authentication: 'plain',
enable_starttls_auto: true,
open_timeout: 5,
read_timeout: 5 }

# Initialize the Rails application.
Rails.application.initialize!
