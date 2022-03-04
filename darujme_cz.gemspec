lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "darujme_cz/version"

Gem::Specification.new do |spec|
  spec.name = "darujme_cz"
  spec.version = DarujmeCz::VERSION
  spec.authors = ["Lukáš Pokorný"]
  spec.email = ["luk4s.pokorny@gmail.com"]

  spec.summary = "Ruby library for work with Darujme.cz API"
  spec.description = "Get pledges or transactions from your organization on Darujme.cz"
  spec.homepage = "https://github.com/luk4s/darujme_cz"
  spec.license = "GPL-3.0-or-later"
  spec.required_ruby_version = '>= 2.5'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"

    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/luk4s/darujme_cz"
    spec.metadata["changelog_uri"] = "https://github.com/luk4s/darujme_cz/CHANGELOG.md"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.test_files = Dir["spec/**/*"]
  # spec.bindir        = "exe"
  # spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", "> 5.2", "< 7"
  spec.add_dependency "money", "~> 6.13"
  spec.add_dependency "rest-client", "~> 2.0"

  spec.add_development_dependency "rake", ">=12.3.3"
  spec.add_development_dependency "rspec", "~> 3.11"
  spec.add_development_dependency "webmock", "~> 3.4"
end
