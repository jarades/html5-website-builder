class Related
  include Mongoid::Document
  field :title, :type => String
  field :path, :type => String
  embedded_in :article
end
