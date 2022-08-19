class Api::V1::PostingsController < Api::V1::ApplicationController
  before_action :authenticate_user!, only: %w[index show destroy update]
  before_action :set_post, only: %w[show destroy update]
  def index
    @posts = current_user.posts.order(updated_at: :desc)
    render :index, formats: :json, handlers: 'jbuilder'
  end

  def show
    render :show, formats: :json, handlers: 'jbuilder'
  end

  def update
    if @post.update(update_params)
      render json: @post, status: :ok
    else
      render json: @post.errors, status: :bad_request
    end
  end

  def destroy
    if @post.destroy
      render json: @post, status: :ok
    else
      render json: @post.errors, status: :bad_request
    end
  end

  private

  def update_params
    params.permit(:title, :description, :content, :status, :grade_range, :scene_type)
  end

  def set_post
    @post = current_user.posts.find(params[:id])
  end
end
