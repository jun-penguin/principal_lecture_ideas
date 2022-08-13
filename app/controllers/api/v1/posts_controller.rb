class Api::V1::PostsController < Api::V1::ApplicationController
  before_action :authenticate_user!, only: %i[create update destroy]

  def index
    @posts = Post.published.preload(:user).order(updated_at: :desc)
    render :index, formats: :json, handlers: 'jbuilder'
  end

  def show
    @post = Post.published.find(params[:id])
    render :show, formats: :json, handlers: 'jbuilder'
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      head :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      render :show, formats: :json, handlers: 'jbuilder'
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

  def search
    modified_search_params = add_search_word(search_params)
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

  def add_search_word(search_params)
    search_word = search_params[:title_or_description_or_content_cont_any]
    full_word = half_to_full(search_word)
    half_word = full_to_half(search_word)
    kana_word = to_kana(search_word)
    hira_word = to_hira(search_word)
    search_params[:title_or_description_or_content_cont_any] = [full_word, half_word, kana_word, hira_word]
    search_params
  end

  def half_to_full(str)
    str.tr('0-9a-zA-Z', '０-９ａ-ｚＡ-Ｚ')
  end

  def full_to_half(str)
    str.tr('０-９ａ-ｚＡ-Ｚ', '0-9a-zA-Z')
  end

  def to_kana(str)
    str.tr('ぁ-ん', 'ァ-ン')
  end

  def to_hira(str)
    str.tr('ア-ン', 'あ-ん')
  end
end
