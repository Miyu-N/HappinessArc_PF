class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id]) 
    if @user.update(user_params)
      flash[:notice] = "ユーザー情報を変更しました"
      redirect_to admin_users_path
    else
      flash.now[:alert] = "保存できませんでした"
      render :edit
    end
  end  
    
    private
    def user_params
      params.require(:user).permit(:name, :username, :email, :introduction, :profile_image, :is_deleted )
    end
end
