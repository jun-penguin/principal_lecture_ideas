class Api::V1::PostingsController < Api::V1::ApplicationController
  before_action :authenticate_user!, only: %w[index show delete update]
  def index
    @posts = current_user.posts.order(created_at: :desc)
    render 'index', formats: :json, handlers: 'jbuilder'
  end

  def show
    @post = Post.find(params[:id])
    render :show, formats: :json, handlers: 'jbuilder'
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      render 'show', formats: :json, handlers: 'jbuilder'
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      head :no_content
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.permit(:title, :description, :content, :status, :grade_range, :scene_type)
  end
end
