source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.4.1'

gem 'active_model_serializers', '~> 0.10.0'
gem 'rails', '~> 5.1.2'
gem 'pg', '~> 0.21.0'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'kaminari', '~> 1.0', '>= 1.0.1'
gem 'uglifier', '>= 1.3.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

group :development, :test do
  gem 'pry-rails', '~> 0.3.6'
  gem 'rspec-rails', '~> 3.6.0'
  gem 'rubocop', require: false
  gem 'factory_girl_rails', '~> 4.8.0'
  gem 'faker', '~> 1.8', '>= 1.8.4'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
