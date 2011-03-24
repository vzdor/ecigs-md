module ProductsHelper
  def tags_links(product)
    product.tags.collect do |tag|
      link_to h(tag.name), tagged_products_path(tag.name)
    end.join(', ').html_safe
  end

  def product_price(product)
    price = product.price
    local_price(price, true) +
      " <span>($#{price.to_usd.round(2)})</span>".html_safe
  end
end
