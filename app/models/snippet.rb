class Snippet
  include Mongoid::Document
  include Mongoid::Timestamps::Short

  field :code,  type: String
  field :spec,  type: String
  field :uid,   type: String

  belongs_to :parent, class_name: 'Snippet'

  field :is_frozen, type: Boolean, default: false

  index({ uid: 1 }, unique: false)

  def fork
    Snippet.create(parent: self, code: code, spec: spec, uid: uid)
  end

  def freeze_snippet(params)
    update_attributes(params.merge(is_frozen: true))
  end
end
