class Admins::PostsController < Admins::BaseController
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @posts = Post.all.order(updated_at: :desc).includes(:user).page(params[:page])
  end

  def show; end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to admins_post_path(@post), success: t('defaults.message.updated', item: Post.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: Post.model_name.human)
      render :edit
    end
  end

  def destroy
    @post.destroy!
    redirect_to admins_posts_path(@post), success: t('defaults.message.deleted', item: Post.model_name.human)
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :content, :status, :grade_range, :scene_type)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
