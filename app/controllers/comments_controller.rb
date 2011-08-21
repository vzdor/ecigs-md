# -*- coding: utf-8 -*-
class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    commentable = find_commentable
    comment = commentable.comments.build(params[:comment])
    comment.user = current_user
    if comment.save
      flash[:notice] = "Отзыв добавлен, спасибо."
      render(:update) { |page| page.redirect_to commentable }
    else
      render :partial => "errors"
    end
  end

  private

  def find_commentable
    this = Product.find(params[:product_id])
    raise ActiveRecord::RecordNotFound unless this.is_commentable?
    this
  end
end
