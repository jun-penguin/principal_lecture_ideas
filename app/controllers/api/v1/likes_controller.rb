class Api::V1::LikesController < Api::V1::ApplicationController
  before_action :authenticate_user!, only: %i[show create destroy]

  def index
    @likes = Like.filter_by_post(params[:post_id]).includes(%i[user post]).order(updated_at: :desc)
    @user = current_user
    render :index, formats: :json, handlers: 'jbuilder'
  end

  def show
    @posts = current_user.favorites.includes(:user).published.order('likes.created_at desc')
    render :show, formats: :json, handlers: 'jbuilder'
  end

  def create
    @like = current_user.likes.new(likes_params)
    @like.save

    head :created
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @like.destroy

    head :ok
  end

  private

  def likes_params
    params.permit(:post_id)
  end
end
