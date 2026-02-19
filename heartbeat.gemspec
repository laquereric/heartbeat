# frozen_string_literal: true

require_relative "lib/heartbeat/version"

Gem::Specification.new do |spec|
  spec.name = "heartbeat"
  spec.version = Heartbeat::VERSION
  spec.authors = ["Eric Laquer"]
  spec.email = ["LaquerEric@gmail.com"]

  spec.summary = "Heartbeat model concerns for Ecosystems engines"
  spec.description = "Reusable HeartBeat and HeartBeatExecution ActiveRecord concerns and migration helpers."
  spec.homepage = "https://github.com/laquereric/heartbeat"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/laquereric/heartbeat"
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ Gemfile .gitignore spec/])
    end
  rescue Errno::ENOENT
    Dir.glob("**/*", base: __dir__).reject { |f| File.directory?(File.join(__dir__, f)) }
  end
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord", ">= 7.1"
  spec.add_dependency "activesupport", ">= 7.1"
end
