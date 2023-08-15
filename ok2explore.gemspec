# frozen_string_literal: true

require_relative 'lib/ok2explore/version'

Gem::Specification.new do |spec|
  spec.name          = 'ok2explore'
  spec.version       = Ok2explore::VERSION
  spec.authors       = ['Holden Mitchell']
  spec.email         = ['hmitchell@9bcorp.com']

  spec.summary       = 'Scraper for Oklahoma Death records'
  spec.description   = 'Scrapes the results of the Ok2Explore website and return JSON response.'
  spec.homepage      = 'https://github.com/AyOK-Code/ok2explore'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 2.7.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/AyOK-Code/ok2explore'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  spec.add_dependency 'selenium-webdriver', '>= 4.11'
  spec.add_dependency 'simplecov', '>= 0.21.2'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 1.12'
  spec.add_development_dependency 'rubocop-rspec', '~> 2.4'
  spec.add_development_dependency 'webmock'

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata['rubygems_mfa_required'] = 'true'
end
