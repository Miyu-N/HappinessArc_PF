class Public::CategoriesController < ApplicationController

  def show
    @categories = Category.all
    @category = Category.find(params[:id])
  end
  
  def category_params
    params.require(:category).permit(:name)
  end
end
