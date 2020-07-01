require_relative 'lib/hey_you_nexmo/version'

Gem::Specification.new do |spec|
  spec.name          = "hey-you-nexmo"
  spec.version       = HeyYouNexmo::VERSION
  spec.authors       = ["Sergey Nesterov"]
  spec.email         = ["qnesterr@gmail.com"]

  spec.summary       = %q{Write a short summary, because RubyGems requires one.}
  spec.description   = %q{Write a longer description or delete this line.}
  spec.homepage      = "https://github.com/QNester/hey-you-nexmo"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.5.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/QNester/hey-you-nexmo"
  spec.metadata["changelog_uri"] = "https://github.com/QNester/hey-you-nexmo/blob/master/CHANGELOG.md"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "hey-you", '~> 1.2'
  spec.add_runtime_dependency "nexmo", '~> 7.1'

  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "webmock", '~> 3.4'
  spec.add_development_dependency "ffaker", '~> 2.9'
  spec.add_development_dependency "byebug"
end
