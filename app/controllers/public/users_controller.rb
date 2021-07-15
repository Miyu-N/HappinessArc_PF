class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @user = current_user
    @posts = @user.posts
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render 'edit'
    end
  end

  def unsubscribe
    @user = User.find(params[:id])
    redirect_to  users_unsubscribe_path
  end


  def withdraw
    current_user.update(is_deleted: true)
    reset_session
    redirect_to root_path
    flash[:notice] = "ご利用ありがとうございました。"
  end


 private

    def user_params
      params.require(:user).permit(:name, :username, :email, :introduction, :profile_image, :is_deleted )
    end
end
