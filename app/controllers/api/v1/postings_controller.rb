class Api::V1::PostingsController < Api::V1::ApplicationController
  before_action :authenticate_user!, only: %w[index show destroy update]
  before_action :verify_access, only: %w[show destroy update]
  def index
    @posts = current_user.posts.order(created_at: :desc)
    render 'index', formats: :json, handlers: 'jbuilder'
  end

  def show
    render :show, formats: :json, handlers: 'jbuilder'
  end

  def update
    if @post.update(post_params)
      render 'show', formats: :json, handlers: 'jbuilder'
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def destroy
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

  def verify_access
    @post = Post.find(params[:id])
    render status: 401, json: { status: 401, message: 'Unauthorized' } unless @post.user == current_user
  end
end
