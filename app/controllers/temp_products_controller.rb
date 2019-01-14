require_relative '../providers/temp_product_provider.rb'

class TempProductsController < ApplicationController
  def index
    @choices = []
    Category.where(user_id: current_user.id).each do |c|
      @choices.push(c.name)
    end
    @choice = @choices.first

    @temp_products = TempProduct.where(user_id: current_user.id)
  end

  def submit
    json_data = JSON.parse(params.require(:temp_products_json)[:json_data])

    json_data.each do |item|
      temp_id = item['id']

      item.delete('id')
      item.delete('created_at')
      item.delete('updated_at')

      product = Product.new(item)

      if product.save
        flash[:notice] = 'Product(s) added'
      else
        flash[:notice] = 'Product(s) adding failed'
        redirect_to action: 'index'
      end

      temp_product = TempProduct.where(user_id: current_user.id).find(temp_id.to_i)
      temp_product.destroy
    end
    redirect_to action: 'index'
  end

  def create
    @temp_product = TempProduct.new(temp_product_params)
    @temp_product.category = params[:category]
    @temp_product.user_id = current_user.id

    flash[:notice] = if @temp_product.save
                       'Product added'
                     else
                       'Product adding failed'
                     end

    redirect_to action: 'index'
  end

  def edit
    @temp_product = TempProduct.where(user_id: current_user.id).find(params[:id])
    @choices = []
    Category.where(user_id: current_user.id).each do |c|
      @choices.push(c.name)
    end
    @choice = @temp_product.category
  end

  def update
    @temp_product = TempProduct.where(user_id: current_user.id).find(params[:id])
    @temp_product.category = params[:category]
    if @temp_product.update(temp_product_params)
      flash[:notice] = 'Product updated'
      redirect_to action: 'index'
    else
      flash[:notice] = 'Product updating failed'
      render action: 'edit'
    end
  end

  def destroy
    @temp_product = TempProduct.where(user_id: current_user.id).find(params[:id])
    @temp_product.destroy
    redirect_to temp_products_path
  end

  def temp_product_params
    params.require(:temp_product).permit(:name, :category, :quantity)
  end
end
