module RedClothProductRefsExtension
  def product_refs(text)
    text.gsub!(/\[\[p:(\d+)\]\]/) do |m|
      "<a href=\"/products/#{$1}\">##{$1}</a>"
    end
  end

  def wiki(text)
    text.gsub!(/\[\[((?:.(?!:))*)\]\]/) do |m|
      "<a href=\"/wiki_pages/#{URI::encode(WikiPage.slug($1))}\">#{$1}</a>"
    end
  end
end
