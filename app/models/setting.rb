class Setting
  include Mongoid::Document
  field :articles_directory, :type => String
  field :site_name, :type => String
  field :tagline, :type => String
end
