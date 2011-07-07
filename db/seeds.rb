# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'EMPTY THE MONGODB DATABASE'
Mongoid.master.collections.reject { |c| c.name =~ /^system/}.each(&:drop)
Setting.create! :articles_directory => 'howto',
  :domain => 'railsapps.github.com',
  :site_name => 'Rails Apps',
  :tagline => 'Rails 3.1 Example Apps and Tutorials',
  :twitter_account => 'rails_apps'
puts 'Set defaults for the app'

data = 
<<-RUBY
h3. Installing the Application

Lorem ipsum dolor sit amet, consectetur adipiscing elit.

h3. Getting Started

Lorem ipsum dolor sit amet, consectetur adipiscing elit.

bq. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
RUBY

Article.create! :title => 'Installing Rails 3.1',
  :filename => 'installing-rails-3-1',
  :description => 'Detailed instructions on how to install Rails 3.1',
  :keywords => 'rails, ruby, apps, application, example, tutorial, install',
  :headline => 'Read This Before Installing Rails 3.1',
  :subhead => 'What You Need to Know',
  :content => data,
  :published => false
puts 'Created a sample article'
