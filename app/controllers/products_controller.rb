class ProductsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]

  before_filter :is_admin_filter, :except => [:index, :show]

  before_filter :get_product, :only => [:show, :edit, :update]

  before_filter :get_tags

  layout 'products'

  def index
    scope = Product.top
    if tag = params[:tag]
      scope = scope.tagged_with(tag)
    end
    @products = scope.page(params[:page]).per(40)
  end

  def new
    @product = Product.new
    3.times { @product.assets.build }
    3.times { @product.variations.build }
  end

  def create
    @product = Product.new(params[:product])
    if @product.save
      flash[:notice] = 'Product created successfully.'
      redirect_to @product
    else
      3.times { @product.assets.build }
      3.times { @product.variations.build }
      render :action => "new"
    end
  end

  def edit
    3.times { @product.assets.build }
    3.times { @product.variations.build }
  end

  def update
    @product.attributes = params[:product]
    if @product.save
      flash[:notice] = 'Product updated successfully.'
      redirect_to @product
    else
      3.times { @product.assets.build }
      3.times { @product.variations.build }
      render :action => "edit"
    end
  end

  private

  def get_product
    @product = Product.find(params[:id])
  end

  def get_tags
    @tags = Product.top.tag_counts_on(:tags)
  end

end
