require 'selenium-webdriver'

module Ok2explore
  class Scraper
    attr_accessor :first_name, :last_name, :month, :year

    def initialize(first_name, last_name, month, year)
      @first_name = first_name
      @last_name = last_name
      @month = month
      @year = year
    end

    def perform
      # Configure Chrome driver options
      options = Selenium::WebDriver::Chrome::Options.new
      options.add_argument('--headless')  # Run Chrome in headless mode
      options.add_argument('--no-sandbox')
      options.add_argument('--disable-dev-shm-usage')
      driver = Selenium::WebDriver.for(:chrome, options: options)
      driver.get('https://ok2explore.health.ok.gov/App/DeathSearch')

      # Find and fill in the first name field
      first_name_input = driver.find_element(:id, 'FirstName')
      first_name_input.send_keys(first_name)

      # Find and fill in the last name field
      last_name_input = driver.find_element(:id, 'LastName')
      last_name_input.send_keys(last_name)

      # Find and select the month
      month_option = driver.find_element(:id, 'DeathMonth')
      month_option.send_keys(month)

      # Find and select the year
      year_option = driver.find_element(:id, 'DeathYear')
      year_option.send_keys(year)  # Assuming '1998' represents the desired year value
      submit_button = driver.find_element(:id, 'deathSearchButton')
      submit_button.click

      # Wait for the page to load and perform further actions as needed
      wait = Selenium::WebDriver::Wait.new(timeout: 10)  # Adjust the timeout value as needed
      results_div = wait.until { driver.find_element(:id, 'gvDeathResults') }
      session_storage = driver.execute_script('return window.sessionStorage')
      
      driver.quit
      return session_storage['deathResults']
    end
  end
end


