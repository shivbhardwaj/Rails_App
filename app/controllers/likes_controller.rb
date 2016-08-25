class LikesController < ApplicationController
  before_action :require_login, only: [:create, :destroy]
  def create
    @like = Like.create(user_id: params[:user_id], secret_id: params[:secret_id])
    if @like.valid?
      redirect_to :back
    else
      flash[:errors] = ["Invalid combination"]
      redirect_to :back
    end
  end

  def destroy
    like = Like.find(params[:id])
    if like.user == current_user
      like.destroy
      redirect_to :back
    else
      flash[:errors]=like.errors.full_messages
      redirect_to "/users/#{session[:user_id]}"
    end
  end
end
