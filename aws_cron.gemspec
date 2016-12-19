# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("../lib", __FILE__)
require "aws_cron/identity"

Gem::Specification.new do |spec|
  spec.name = AwsCron::Identity.name
  spec.version = AwsCron::Identity.version
  spec.platform = Gem::Platform::RUBY
  spec.authors = ["Marco Costa"]
  spec.email = ["mmarcottulio@gmail.com"]
  spec.homepage = ""
  spec.summary = ""
  spec.license = "MIT"

  if File.exist?(Gem.default_key_path) && File.exist?(Gem.default_cert_path)
    spec.signing_key = Gem.default_key_path
    spec.cert_chain = [Gem.default_cert_path]
  end

  spec.add_development_dependency "rake", "~> 11.0"
  spec.add_development_dependency "gemsmith", "~> 8.1"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "pry-byebug", "~> 3.4"
  spec.add_development_dependency "pry-state", "~> 0.1"
  spec.add_development_dependency "rspec", "~> 3.5"
  spec.add_development_dependency "guard-rspec", "~> 4.7"
  spec.add_development_dependency "reek", "~> 4.5"
  spec.add_development_dependency "rubocop", "~> 0.45"

  spec.files = Dir["lib/**/*"]
  spec.extra_rdoc_files = Dir["README*", "LICENSE*"]
  spec.require_paths = ["lib"]
end
