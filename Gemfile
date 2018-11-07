source "https://rubygems.org"

ruby '2.5.1'

gem 'rake'
gem 'rubocop', '0.56.0'

group :development, :test do
  gem "rspec"
  gem 'simplecov', require: false
  gem 'simplecov-console', require: false
end

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }
