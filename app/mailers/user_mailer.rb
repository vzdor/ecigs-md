# -*- coding: utf-8 -*-
class UserMailer < ActionMailer::Base
  default :from => "vr.zdor@gmail.com" #, :reply_to => "vr.zdor+ecigs@gmail.com"

  def new_order_email(order)
    @order = order
    @user = order.user
    mail(:to => @user.email,
         :cc => "vr.zdor@gmail.com",
         :subject => "[ecigs.md] Подтверждение получения заказа №#{order.id}")
  end
end
