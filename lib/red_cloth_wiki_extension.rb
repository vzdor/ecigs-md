module RedClothWikiExtension
  def wiki(text)
    text.gsub!(/\[\[((?:.(?!:))*)\]\]/) do |m|
      "<a href=\"/wiki_pages/#{URI::encode(WikiPage.slug($1))}\">#{$1}</a>"
    end
  end
end
