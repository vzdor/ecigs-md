module ProductsHelper
  def tags_links(product)
    product.tags.collect do |tag|
      link_to h(tag.name), tagged_products_path(tag.name)
    end.join(', ').html_safe
  end

  def product_price(product)
    if product.is_variable_price?
      price = product.lowest_variation_price
    else
      price = product.price
    end
    show_price(price)
  end

  def show_price(price)
    local_price(price, true) +
      " <span>($#{price.to_usd.round(2)})</span>".html_safe
  end
end
