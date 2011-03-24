# -*- coding: utf-8 -*-
module ApplicationHelper
  def title(page_title, show_title = true)
    @show_title = show_title
    content_for(:title) { page_title }
  end

  def tabs
    [[:products, :the_shop, products_path],
     [:delivery, :delivery_payment, delivery_home_path],
     [:contacts, :contacts, contacts_home_path],
     [:faq, :faq, 'http://www.ecigtalk.ru/forum/f14/t3366.html'],
     # [:blog, :blog, 'http://blog.ecigs.md']
    ].collect do |k, title, path|
      css_class = 'active' if k == @tab
      content_tag(:li, link_to(h(I18n.t(title)), path, :class => css_class), :class => css_class)
    end.join.html_safe
  end

  def textilize(text)
    RedCloth.new(text).to_html.html_safe unless text.blank?
  end

  def local_price(price, show_currency = false)
    (show_currency ? "#{price} лей" : price.to_s).html_safe
  end
end
