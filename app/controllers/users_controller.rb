class UsersController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update]

  # def index
  # end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
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
                              :imge, :image_cashe,:password_confirmation,:introduce)
  end

  def set_blog
    @user = User.find(params[:id])
  end        
end
