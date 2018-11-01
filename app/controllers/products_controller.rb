# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    @products = Product.where(user_id: current_user.id)
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
      flash[:notice] = 'Product addeupdated'
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

  private def product_params
    params.require(:product).permit(:name, :shop, :category, :price, :quantity)
  end
end
