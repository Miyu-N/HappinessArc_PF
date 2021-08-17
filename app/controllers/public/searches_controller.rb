class Public::SearchesController < ApplicationController
  
  def search
    @model = params["search"]["model"]
    @value = params["search"]["value"]
    @datas = search_for(@model, @value)
  end
  
  
  private
  
  def search_for(model, value)
    if model == 'user'
      User.where("name || username LIKE ?", "%#{value}%")
    elsif model == 'post'
      Post.where("title || category LIKE ?", "%#{value}%")
    end
  end
  
end
