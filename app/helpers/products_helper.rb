module ProductsHelper
  def tags_links(product)
    product.tags.collect do |tag|
      link_to h(tag.name), tagged_products_path(tag.name)
    end.join(', ').html_safe
  end
end
