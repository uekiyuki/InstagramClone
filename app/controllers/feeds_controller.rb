class FeedsController < ApplicationController
  before_action :set_feed, only: [:show, :update, :edit, :destroy]
  # before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @feeds = Feed.all
  end

  def show
      @favorite = current_user.favorites.find_by(feed_id: @feed.id)#binsding.irb
  end

  def new
    if params[:back]
      @feed = Feed.new(feed_params)
    else
      @feed = Feed.new
    end
  end

  def confirm
    @feed = current_user.feeds.build(feed_params) #現在ログインしているuserのidを、blogのuser_idカラムに挿入する
    render :new if @feed.invalid?
  end

  def edit
    if @feed.user_id != current_user.id
      redirect_to feed_path, notice:"権限がありません"
    end
  end

  def create
    @feed = current_user.feeds.build(feed_params)
    respond_to do |format|
      if @feed.save
        format.html { redirect_to @feed, notice: 'Feed was successfully created.' }
        format.json { render :show, status: :created, location: @feed }
        ContactMailer.contact_mail(@feed).deliver
      else
        format.html { render :new }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @feed.update(feed_params)
        format.html { redirect_to @feed, notice: 'Feed was successfully updated.' }
        format.json { render :show, status: :ok, location: @feed }
      else
        format.html { render :edit }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @feed.destroy
    respond_to do |format|
      format.html { redirect_to feeds_url, notice: 'Feed was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_feed
      @feed = Feed.find(params[:id])
  end

  def feed_params
    params.require(:feed).permit(:image, :image_cache, :title, :content)
  end

  # def correct_user
  #   @feed = Feed.find(params[:id])
  #   @feed.user_id = current_user.id
  #   # belong_toのおかげでnoteオブジェクトからuserオブジェクトへアクセスできる。
  #   if @feed.id = current_user.id
  #     redirect_to edit_feed_path(@feed)
  #   end
  # end
end