require 'selenium-webdriver'

module Ok2explore
  class Scraper
    # Configure Chrome driver options
options = Selenium::WebDriver::Chrome::Options.new
options.add_argument('--headless')  # Run Chrome in headless mode
options.add_argument('--no-sandbox')
options.add_argument('--disable-dev-shm-usage')

# Set Chrome driver path
#driver_path = '/usr/local/bin/chromedriver'  # Replace with th# Configure Chrome driver options

# Set Chrome driver service
#Selenium::WebDriver::Chrome.driver_path = driver_path

# Initialize Selenium WebDriver
driver = Selenium::WebDriver.for(:chrome, options: options)

# Navigate to the webpage
driver.get('https://ok2explore.health.ok.gov/App/DeathSearch')

# Find and fill in the first name field
first_name_input = driver.find_element(:id, 'FirstName')
first_name_input.send_keys('J*')

# Find and fill in the last name field
last_name_input = driver.find_element(:id, 'LastName')
last_name_input.send_keys('J*')

# Find and select the month
month_option = driver.find_element(:id, 'DeathMonth')
month_option.send_keys('2')  # Assuming '4' represents the desired month value

# Find and select the year
year_option = driver.find_element(:id, 'DeathYear')
year_option.send_keys('1998')  # Assuming '1998' represents the desired year value

# Submit the form
submit_button = driver.find_element(:id, 'deathSearchButton')
submit_button.click

# Wait for the page to load and perform further actions as needed
# Wait for the search results to load
wait = Selenium::WebDriver::Wait.new(timeout: 10)  # Adjust the timeout value as needed
results_div = wait.until { driver.find_element(:id, 'gvDeathResults') }

# Access the browser session
session_storage = driver.execute_script('return window.sessionStorage')
# Access specific values from session storage
value = session_storage['deathResults']

puts value
# Close the browser
driver.quit
  end
end


