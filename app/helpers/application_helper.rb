module ApplicationHelper
  def title(page_title, show_title = true)
    @show_title = show_title
    content_for(:title) { page_title }
  end

  def tabs
    [[:products, 'Products', products_path],
     [:delivery, 'Delivery and Payment', delivery_home_path],
     [:contacts, 'Contacts', contacts_home_path],
     [:blog, 'Blog', 'http://blog.ecigs.md']].collect do |k, title, path|
      css_class = 'active' if k == @tab
      content_tag(:li, link_to(h(title), path, :class => css_class), :class => css_class)
    end.join.html_safe
  end
end
