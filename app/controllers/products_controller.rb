class ProductsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]

  before_filter :is_admin_filter, :except => [:index, :show]

  before_filter :get_product, :only => [:show, :edit, :update]

  def index
    scope = is_admin? ? Product : Product.in_stock
    @tags = scope.tag_counts_on(:tags)
    if tag = params[:tag]
      scope = scope.tagged_with(tag)
    end
    @products = scope.page(params[:page]).per(40)
  end

  def new
    @product = Product.new
    3.times { @product.assets.build }
  end

  def create
    @product = Product.new(params[:product])
    if @product.save
      flash[:notice] = 'Product created successfully.'
      redirect_to @product
    else
      render :action => "new"
    end
  end

  def edit
    3.times { @product.assets.build }
  end

  def update
    @product.attributes = params[:product]
    if @product.save
      flash[:notice] = 'Product updated successfully.'
      redirect_to @product
    else
      render :action => "new"
    end
  end

  private

  def get_product
    @product = Product.find(params[:id])
  end
end
