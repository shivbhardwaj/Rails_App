class UsersController < ApplicationController
  # before_action :logged_in?, only: [:show]
  before_action :require_login, except: [:new, :create]
  before_action :require_correct_user, only: [:show, :edit, :update, :destroy]
  def show
    #@user = User.find(params[:id])
    @user=User.find(params[:id])
    @secrets=@user.secrets.all
  end

  def new
    session[:user_id]=nil
  end

  def create
    @user=User.create user_params
    if (@user.save)
      session[:user_id]=@user.id
      redirect_to "/users/#{@user.id}"
    else
      flash[:errors]=@user.errors.full_messages
      #warn ".........#{flash[:errors]}"
      redirect_to "/users/new"
    end
  end

  def edit
    @user=User.find(params[:id])
  end

  def update
    @user=User.find(params[:id])
    puts @user.id
    @user.update(user_params)
    #User.update(params[:id], name: params[:name], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
    redirect_to show_user_path
  end

  def destroy
    User.find(params[:id]).destroy
    session.clear
    redirect_to new_session_path
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
