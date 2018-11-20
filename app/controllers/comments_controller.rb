class CommentsController < ApplicationController
  def create
    id = params[:comment][:id]
    content = params[:comment][:text]
    if Comment.exists?(product_id: id)
      Comment.where(product_id: id).update_all(content: content)
    else
      Comment.create(product_id: id, content: content)
    end
    redirect_to products_url
  end
end
