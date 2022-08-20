class Api::V1::CommentsController < Api::V1::ApplicationController
  before_action :authenticate_user!, only: %i[create update destroy]
  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments.includes(%i[user post]).order(created_at: :desc)
    # @comments = Comment.filter_by_post(params[:post_id]).includes(%i[user post]).order(updated_at: :asc)
    @user = current_user
    render :index, formats: :json, handlers: 'jbuilder'
  end

  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      render json: @comment, status: :ok
    else
      render @comment.errors, status: :bad_request
    end
  end

  def update
    @comment = current_user.comments.find(params[:id])
    if @comment.update(update_params)
      render json: @comment, status: :ok
    else
      render json: @comment.errors, status: :ok
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    if @comment.destroy
      render json: @comment, status: :ok
    else
      render json: @comment.errors, status: :bad_request
    end
  end

  private

  def comment_params
    params.permit(:post_id, :body)
  end

  def update_params
    params.permit(:body)
  end
end
