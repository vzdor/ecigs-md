module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title }
  end

  def tabs
    [['Products', products_path],
     ['Delivery', delivery_home_path],
     ['Contacts', contacts_home_path],
     ['Blog', 'http://blog.ecigs.md']].collect do |title, path|
      css_class = 'active' if title == @tab
      content_tag(:li, link_to(h(title), path, :class => css_class), :class => css_class)
    end.join.html_safe
  end
end
