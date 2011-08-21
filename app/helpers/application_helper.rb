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
     [:faq, :faq, faq_home_path]
    ].collect do |k, title, path|
      css_class = 'active' if k == @tab
      content_tag(:li, link_to(h(I18n.t(title)), path, :class => css_class), :class => css_class)
    end.join.html_safe
  end

  def textilize(text)
    RedCloth.new(text).to_html(:textile, :product_refs, :wiki).html_safe unless text.blank?
  end

  def wikify(text)
    textilize(text)
  end

  def local_price(price, show_currency = false)
    (show_currency ? "#{price} лей" : price.to_s).html_safe
  end

  def star_select(field, score = 4)
    html = ''
    (1..5).each do |n|
      html << content_tag(:li) do
        content_tag(:a, nil, :class => "star-#{n}", :title => "#{n} из 5")
      end
    end
    show_stars(0, html.html_safe) + javascript_tag('bindStars()');
  end

  def show_stars(score, inner = '')
     content_tag(:span, :class => 'inline') do
      content_tag(:ul, :class => 'rating') do
        content_tag(:li, nil, :class => 'current-rating', :style => "width: #{score * 20}%;") + inner
      end
    end
  end
end

