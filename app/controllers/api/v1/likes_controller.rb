class Api::V1::LikesController < Api::V1::ApplicationController
  before_action :authenticate_user!, only: %i[show create destroy]

  def index
    @likes = Like.filter_by_post(params[:post_id])
    # binding.pry
    # .select(:id, :user_id, :post_id)
    @user = current_user
    #  if user_signed_in?
    render :index, formats: :json, handlers: 'jbuilder'
  end

  def show
    @posts = current_user.favorites
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
