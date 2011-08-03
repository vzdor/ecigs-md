Factory.define :wiki_page, :class => WikiPage do |wiki|
  wiki.sequence(:title) { |n| "Test #{n}" }
  wiki.sequence(:slug) { |n| "test-#{n}" }
  wiki.content "Test test"
  wiki.is_visible true
end
