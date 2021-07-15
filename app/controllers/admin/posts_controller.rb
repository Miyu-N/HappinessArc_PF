class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @posts = Post.all.page(params[:page]).per(10).reverse_order
    @categories = Category.all
    @category = Category.find_by(id: params[:genre_id])
  end
  
  
  def search
    @category = Category.find_by(id: params[:genre_id])
    @posts = Post.all.page(params[:page]).per(8)
  end
  
  def show
    @post = Post.find(params[:id])
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :image, :body, :user_id, :category_id)
  end
end
