module RedClothProductRefsExtension
  def product_refs(text)
    text.gsub!(/\[\[p:(\d+)\]\]/) do |m|
      "<a href=\"/products/#{$1}\">##{$1}</a>"
    end
  end
end
