require_relative '../providers/product_provider.rb'
require_relative '../providers/report_provider.rb'

class ProductsController < ApplicationController
  before_action :select_categories

  def index
    @period = (params[:period] || ProductProvider.dates[0])
    @products = Product.where(user_id: current_user.id).order('created_at')
    @products = @products.where('created_at > ?', ProductProvider.date_selector(@period)) if @period != 'All'
  end

  def statistics
    @period = (params[:period] || ProductProvider.dates[0])
    @categories = Category.where(user_id: current_user.id)
    @products = Product.where(user_id: current_user.id).order('created_at')
    @products = @products.where('created_at > ?', ProductProvider.date_selector(@period)) if @period != 'All'
  end

  def new; end

  def create
    @product = Product.new(product_params)
    @product.category = params[:category]
    @product.user_id = current_user.id

    if @product.save
      ReportProvider.check_plans(current_user.id)
      flash[:notice] = 'Product added'
      redirect_to action: 'index'
    else
      flash[:notice] = 'Product adding failed'
      render action: 'new'
    end
  end

  def edit
    @product = Product.where(user_id: current_user.id).find(params[:id])
    @choice = @product.category
  end

  def update
    @product = Product.where(user_id: current_user.id).find(params[:id])
    @product.category = params[:category]
    if @product.update(product_params)
      ReportProvider.check_plans(current_user.id)
      flash[:notice] = 'Product updated'
      redirect_to action: 'index'
    else
      flash[:notice] = 'Product updating failed'
      render action: 'edit'
    end
  end

  def destroy
    @product = Product.where(user_id: current_user.id).find(params[:id])
    @product.destroy
    redirect_to products_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :shop, :category, :price, :quantity)
  end

  def select_categories
    @choices = []
    Category.where(user_id: current_user.id).each do |c|
      @choices.push(c.name)
    end
    @choice = @choices.first
  end
end
