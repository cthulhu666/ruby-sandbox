FactoryGirl.define do
  factory :snippet do
    code '# foo'
    spec '# bar'
    is_frozen false
  end
end
