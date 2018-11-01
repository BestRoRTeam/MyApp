class ProductsController < ApplicationController
  def index
    @products = Product.where(:user_id => current_user.id)
  end

  def new
  end

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

  private def product_params
    params.require(:product).permit(:name, :shop, :category, :price, :quantity)
  end
end