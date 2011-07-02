class Article
  include Mongoid::Document
  field :title, :type => String
  field :filename, :type => String
  field :description, :type => String
  field :h1, :type => String
  field :h2, :type => String
  key :filename
end
