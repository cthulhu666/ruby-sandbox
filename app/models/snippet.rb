class Snippet
  include Mongoid::Document
  include Mongoid::Timestamps::Short

  field :code, type: String
  field :spec, type: String

end
