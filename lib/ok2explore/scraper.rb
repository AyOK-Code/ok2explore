require 'selenium-webdriver'

module Ok2explore
  class Scraper
    attr_accessor :first_name, :last_name, :month, :year, :day, :driver

    # TODO: Add args middle_name, date_range?, gender, county
    def initialize(**kwargs)
      valid_params(kwargs.keys)
      @first_name = kwargs[:first_name]
      @last_name = kwargs[:last_name]
      @month = kwargs[:month]
      @year = kwargs[:year]
      @day = kwargs[:day]
      @driver = set_chromedriver
    end

    def perform
      driver.get('https://ok2explore.health.ok.gov/App/DeathSearch')
      fill_field('FirstName', first_name) if param_exists(first_name)
      fill_field('LastName', last_name) if param_exists(last_name)
      fill_field('DeathDay', day) if param_exists(day)
      fill_field('DeathMonth', month) if param_exists(month)
      fill_field('DeathYear', year) if param_exists(year)

      data = submit_and_wait
      return data
    end

    private

    def fill_field(field_id, value)
      input = driver.find_element(:id, field_id)
      input.send_keys(value)
    end

    def param_exists(param)
      !param.nil? && !param.empty?
    end

    def set_chromedriver
      options = Selenium::WebDriver::Chrome::Options.new
      options.add_argument('--headless')
      options.add_argument('--no-sandbox')
      options.add_argument('--disable-dev-shm-usage')
      Selenium::WebDriver.for(:chrome, options: options)
    end

    def valid_params(keys)
      valid = [:first_name, :last_name, :month, :year, :day]
      invalid_params = keys.difference(valid)
      if invalid_params.count.positive?
          raise Ok2explore::Errors::InvalidParams,
            "Invalid Params: #{invalid_params.join(', ')}"
      end
    end

    def submit_and_wait
      submit_button = driver.find_element(:id, 'deathSearchButton')
      submit_button.click

      begin
        wait = Selenium::WebDriver::Wait.new(timeout: 10)
        # Look for model indicating too many results
        
        wait.until { driver.find_element(tag_name: 'h4') }
        bootbox = wait.until { driver.find_element(css: '.bootbox-body') }
        text = bootbox.attribute('innerHTML')
        match = text.match(/\b(\d+)\b/)
        number = match[1].to_i
        raise Ok2explore::Errors::TooManyResults,
          "#{number} results returned. Please narrow your search."
      rescue Selenium::WebDriver::Error::TimeoutError
        puts 'Search successful'
        wait.until { driver.find_element(:id, 'gvDeathResults') }
        return get_results
      end
    end

    def get_results
      session_storage = driver.execute_script('return window.sessionStorage')
      driver.quit
      JSON.parse(session_storage['deathResults'])
    end
  end  
end


