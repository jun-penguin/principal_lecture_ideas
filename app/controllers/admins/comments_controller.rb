class Admins::CommentsController < Admins::BaseController
  before_action :set_comment, only: %i[show edit update destroy]

  def index
    @comments = Comment.all.order(updated_at: :desc).includes(%i[user post]).page(params[:page])
  end

  def show; end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to admins_comment_path(@comment), success: t('defaults.message.updated', item: Comment.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: Comment.model_name.human)
      render :edit
    end
  end

  def destroy
    @comment.destroy!
    redirect_to admins_comments_path(@comment), success: t('defaults.message.deleted', item: Post.model_name.human)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
