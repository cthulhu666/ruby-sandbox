json.snippet do
  json.id @snippet.id.to_s
  json.call(@snippet, :code, :spec, :uid, :is_frozen, :parent_id)
end
