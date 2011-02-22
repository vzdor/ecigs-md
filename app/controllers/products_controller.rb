class ProductsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]

  before_filter :is_admin_filter, :except => [:index, :show]

  before_filter :get_product, :only => [:show, :edit, :update]

  def index
    @products = Product.find(:all)
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params[:product])
    if @product.save
      flash[:notice] = 'Product saved successfully.'
      redirect_to product_path(@product)
    else
      render :action => "new"
    end
  end

  def edit
  end

  def update
    @product.attributes = params[:product]
    if @product.save
      flash[:notice] = 'Product saved successfully.'
      redirect_to product_path(@product)
    else
      render :action => "new"
    end
  end

  private

  def get_product
    @product = Product.find(params[:id])
  end
end
