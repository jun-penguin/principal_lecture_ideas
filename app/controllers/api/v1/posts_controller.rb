class Api::V1::PostsController < Api::V1::ApplicationController
  before_action :authenticate_user!, only: %i[create update destroy]

  def index
    @posts = Post.published.includes(%i[user likes comments]).order(updated_at: :desc)
    render :index, formats: :json, handlers: 'jbuilder'
  end

  def show
    @post = Post.published.find_by_hashid(params[:id])
    render :show, formats: :json, handlers: 'jbuilder'
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      render json: @post, status: :ok
    else
      render json: @post.errors, status: :bad_request
    end
  end

  def search
    modified_search_params = self.class.helpers.add_search_word(search_params)
    @q = Post.preload(:user).published.ransack(modified_search_params)
    @posts = @q.result(distinct: true).order(created_at: :desc)
    render :search, formats: :json, handlers: 'jbuilder'
  end

  private

  def post_params
    params.permit(:title, :description, :content, :status, :grade_range, :scene_type)
  end

  def search_params
    params.require(:q).permit(:title_or_description_or_content_cont_any, :grade_range_eq, :scene_type_eq)
  end

end
