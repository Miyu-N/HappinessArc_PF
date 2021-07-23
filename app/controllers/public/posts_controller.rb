class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  
  
  def new
    @post = Post.new
  end
  
  def index
    @posts = Post.all.page(params[:page]).per(8)
    @categories = Category.all
  end
  
  def create
    @post = Post.new(post_params)
     @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post)
      flash[:notice] = "投稿しました"
    else
      render 'new'
    end
  end
  
  def show
    @post = Post.find(params[:id])
  end  
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    if @post.update(post_params)
      redirect_to post_path(@post)
      flash[:notice] = "変更しました"
    else
      render "edit"
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
    flash[:notice] = "投稿を削除しました"
  end  
  
  def like
    @post = Post.find(params[:id])
    @likes = Like.where(post_id: @post.id)
  end
  
  def weekly_rank
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    @posts = Post.includes(:liked_users).
      sort { |a, b|
        b.liked_users.includes(:likes).where(created_at: from...to).size <=>
        a.liked_users.includes(:likes).where(created_at: from...to).size
      }
  end

  
  private
  def post_params
      params.require(:post).permit(:title, :image, :body, :user_id, :category_id)
  end
  

end  
