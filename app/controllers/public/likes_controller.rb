class Public::LikesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @post = Post.find(params[:post_id])
    @like = current_user.likes.build(post_id: params[:post_id])
    @like.save
    
  end
  
  def destroy
    @post = post.find(params[:post_id])
    @like = Like.ffind_by(post_id: params[:post_id], usser_id: current_user_id)
    @like.destroy
    
  end 
  
  private
  
  def like_params
    params.permit(:post_id)
  end  
end
