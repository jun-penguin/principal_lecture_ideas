class Api::LikesController < ApplicationController
  before_action :authenticate_user!
  # , only: %i[create destroy]

  def index
    @likes = Like.filter_by_post(params[:post_id])
    # .select(:id, :user_id, :post_id)
    @user = current_user
    #  if user_signed_in?
    render :index, formats: :json, handlers: 'jbuilder'
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