class Article
  include Mongoid::Document
  field :title, :type => String
  field :filename, :type => String
  field :description, :type => String
  field :keywords, :type => String
  field :headline, :type => String
  field :subhead, :type => String
  field :content, :type => String
  field :published, :type => Boolean
  key :filename
  embeds_many :related
  accepts_nested_attributes_for :related
end
