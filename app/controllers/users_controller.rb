class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  before_action :set_feed, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id), notice: "プロフィールを登録しました！"
    else
      render 'new'
    end
  end
  
  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "プロフィールを編集しました！"
    else
      render :edit
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password,
                              :image, :image_cache,:password_confirmation,:introduce)
  end

  def set_feed
    @user = User.find(params[:id])
  end
  
  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to user_path
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
  end
end
