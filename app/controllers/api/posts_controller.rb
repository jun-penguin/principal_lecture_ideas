class Api::PostsController < ApplicationController
  before_action :authenticate_user!, only: ['create', 'update', 'destroy']
  def index
    @posts = Post.published
    render :index, formats: :json, handlers: 'jbuilder'
  end

  def show
    @post = Post.published.find(params[:id])
    render :show, formats: :json, handlers: 'jbuilder'
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      head :no_content
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      render 'index', formats: :json, handlers: 'jbuilder'
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
