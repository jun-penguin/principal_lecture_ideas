class Api::PostsController < ApplicationController
  def index
    @posts = Post.all
    render :index, formats: :json, handlers: 'jbuilder'
  end

  def show
    @post = Post.find(params[:id])
    render :show, formats: :json, handlers: 'jbuilder'
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      head :no_content
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.permit(:title, :description, :content, :status, :grade_range, :scene_type, :user_id)
  end
end
