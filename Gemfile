# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

root_dir = File.expand_path(".", __dir__)
raw_ruby_ver = File.read(File.join(root_dir, ".ruby-version")).chomp
ruby_ver = raw_ruby_ver.split(".")[0..1].join(".")
ruby "~> #{ruby_ver}"

gem "pg",     "~> 1.1"
gem "puma",   "~> 6.4.2"
RAILS_VERSION_SPECIFIER = ["~> 7.0.3"].freeze
gem "actionmailer", *RAILS_VERSION_SPECIFIER
gem "actionpack", *RAILS_VERSION_SPECIFIER
gem "actionview", *RAILS_VERSION_SPECIFIER
gem "activemodel", *RAILS_VERSION_SPECIFIER
gem "activerecord", *RAILS_VERSION_SPECIFIER
gem "activestorage", *RAILS_VERSION_SPECIFIER
gem "activesupport", *RAILS_VERSION_SPECIFIER
gem "railties", *RAILS_VERSION_SPECIFIER

gem "devise",         "~> 4.8"
gem "mail",           "~> 2.8.1"
gem "rack-cors",      "~> 2.0.0"

gem "cssbundling-rails",       "~> 1.3.3"
gem "haml-rails",              "~> 2.0"
gem "jsbundling-rails",        "~> 1.2.1"
gem "propshaft",               "~> 0.7.0"

gem "dotenv-rails", "~> 2.7"

gem "avo",          ">= 3.0.1.beta9", source: "https://packager.dev/avo-hq/"
gem "avo-advanced",                   source: "https://packager.dev/avo-hq/"
gem "pundit",       "~> 2.3.1"

gem "bootsnap", ">= 1.4.2", require: false
gem "listen", "~> 3.2"
gem "pry"
gem "pry-rails"

group :development do
  gem "better_errors",     "~> 2.10.1"
  gem "binding_of_caller", "~> 1.0"

  gem "spring", "~> 4.0"

  gem "foreman", require: false
end
