class CategoriesController < ApplicationController
  def index
    @dates = %w[Week Month Year All]
    @period = (params[:period] || @dates[0])
    @categories = Category.where(user_id: current_user.id).order('created_at')
  end

  def new; end

  def create
    @category = Category.new(category_params)
    @category.user_id = current_user.id
    @categories = Category.where(user_id: current_user.id).order('created_at')

    if @category.save
      flash[:notice] = 'Category added'
      redirect_to action: 'index'
    else
      flash[:notice] = 'Category adding failed'
      render action: 'index'
    end
  end

  def edit
    @category = Category.where(user_id: current_user.id).find(params[:id])
  end

  def update
    @category = Category.where(user_id: current_user.id).find(params[:id])
    if @category.update(category_params)
      flash[:notice] = 'Category updated'
      redirect_to action: 'index'
    else
      flash[:notice] = 'Category updating failed'
      render action: 'edit'
    end
  end

  def destroy
    @category = Category.where(user_id: current_user.id).find(params[:id])
    @category.destroy
    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
