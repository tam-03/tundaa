# frozen_string_literal: true

require "selenium-webdriver"

Capybara.register_driver :remote_selenium do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument("--headless")
  options.add_argument("--window-size=1400,1400")
  options.add_argument("--no-sandbox")
  options.add_argument("--disable-dev-shm-usage")

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    url: ENV.fetch("SELENIUM_DRIVER_URL"),
    options: options,
  )
end

selenium_app_host = ENV.fetch("SELENIUM_APP_HOST") do
  Socket.ip_address_list
        .find(&:ipv4_private?)
        .ip_address
end

Capybara.configure do |config|
  config.server = :puma, { Silent: true }
  config.server_host = selenium_app_host
  config.server_port = 3000
end

RSpec.configure do |config|
  config.before(:each, type: :system, js: true) do |example|
    Capybara.app_host = "http://#{Capybara.server_host}:#{Capybara.server_port}"
    driven_by(:remote_selenium)
  end
end
