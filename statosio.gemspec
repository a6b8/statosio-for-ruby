# frozen_string_literal: true

require_relative "lib/statosio/version"

Gem::Specification.new do |spec|
  spec.name          = "statosio"
  spec.version       = Statosio::VERSION
  spec.authors       = ["a6b8"]
  spec.email         = ["hello13plus4.com"]

  spec.summary       = "Statosio generate charts in a .svg format."
  spec.description   = "Statosio generate charts in a .svg format. Works with prawn-svg to generate .pdf documents."
  spec.homepage      = "https://d3.statoiso.com"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.4.0"

  spec.metadata["allowed_push_host"] = "Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://d3.statoiso.com"
  spec.metadata["changelog_uri"] = "https://d3.statoiso.com"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| 
      puts f
      puts f.match(%r{\A(?:test|spec|features)/})
      puts '___'
      f.match(%r{\A(?:test|spec|features)/}) 
    }
  end


  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "json", "~> 2.5.1"
  spec.add_dependency "puppeteer-ruby", "~> 0.32.3"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
