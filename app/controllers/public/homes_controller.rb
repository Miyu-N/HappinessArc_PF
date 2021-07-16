class Public::HomesController < ApplicationController
  
  def top
    @posts = Post.all
    # @categories = Category.all
    # @category = Categoty.find_by(id: params[:category_id])
  end
  
  def about
  end  
end
