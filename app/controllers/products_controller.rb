# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    @dates = %w[Week Month Year All]
    @period = (params[:period] || @dates[0])
    @products = Product.where(user_id: current_user.id).order('created_at')
    @products = @products.where('created_at > ?', date_selector(@period)) if @period != 'All'
  end

  def new; end

  def create
    @product = Product.new(product_params)
    @product.user_id = current_user.id

    if @product.save
      flash[:notice] = 'Product added'
      redirect_to action: 'index'
    else
      flash[:notice] = 'Product adding failed'
      render action: 'new'
    end
  end

  def edit
    @product = Product.where(user_id: current_user.id).find(params[:id])
  end

  def update
    @product = Product.where(user_id: current_user.id).find(params[:id])
    if @product.update(product_params)
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

  def date_selector(choice)
    if choice == 'Week'
      1.week.ago
    elsif choice == 'Month'
      1.month.ago
    elsif choice == 'Year'
      12.months.ago
    end
  end
end
