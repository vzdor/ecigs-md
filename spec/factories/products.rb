
Factory.define :product, :class => Product do |product|
  product.title "Joey eGo starter kit"
  product.summary "test *test* test"
  product.description "Manual Joye eGo starter kit with 2 atomizer options and 4 color options"
  product.price 1100
  product.quantity 10
end

Factory.define :variation, :parent => :product do |v|
  v.association :product
  v.price 1
  v.quantity 1
end

Factory.define :mixture, :parent => :product do |m|
  m.after_build do |o|
    cat = Factory.build(:variation, :title => "Base", :product => o)
    cat.variations =
      [Factory.build(:variation, :title => "PG", :product => cat),
       Factory.build(:variation, :title => "PGVG", :product => cat)]

    cat2 = Factory.build(:variation, :title => "Flavor", :product => o)
    cat2.variations =
      [Factory.build(:variation, :title => "Gold Ducat", :product => cat2),
       Factory.build(:variation, :title => "Royal", :product => cat2)]
    o.variations = [cat, cat2]
  end
  m.is_mixture true
end
