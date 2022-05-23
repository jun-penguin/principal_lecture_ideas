class Api::LikesController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: Like.filter_by_post(params[:post_id]).select(:id, :user_id, :post_id)
  end

  def create
    @like = current_user.likes.new(likes_params)
    @like.save
    
    head :created
  end

  def destroy
    current_user.likes.find(params[:id])
    @like.destroy

    head :ok
  end

  private

  def likes_params
    params.permit(:post_id)
  end
end
