class Api::V1::LikesController < Api::V1::ApplicationController
  before_action :authenticate_user!, only: %i[show create destroy]

  def index
    @post = Post.find(params[:post_id])
    @likes = @post.likes.includes(%i[user post]).order(updated_at: :desc)
    @user = current_user
    render :index, formats: :json, handlers: 'jbuilder'
  end

  def create
    @like = current_user.likes.new(likes_params)
    if @like.save
      render json: @like, status: :ok
    else
      render json: @like.errors, status: :bad_request
    end
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    if @like.destroy
      render json: @like, status: :ok
    else
      render json: @like.errors, status: :bad_request
    end
  end

  def favorites
    @posts = current_user.favorites.includes(:user).published.order('likes.created_at desc')
    render :favorites, formats: :json, handlers: 'jbuilder'
  end

  private

  def likes_params
    params.permit(:post_id)
  end
end
