class Api::V1::CommentsController < Api::V1::ApplicationController
  before_action :authenticate_user!, only: %i[create update destroy]
  def index
    @comments = Comment.includes(:user).filter_by_post(params[:post_id]).order(updated_at: :asc)
    @user = current_user
    render :index, formats: :json, handlers: 'jbuilder'
  end

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.save
    head :created
  end

  def update
    @comment = current_user.comments.find(params[:id])
    @comment.update(update_params)
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy
  end

  private

  def comment_params
    params.permit(:post_id, :body)
  end

  def update_params
    params.permit(:body)
  end
end