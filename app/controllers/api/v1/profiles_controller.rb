class Api::V1::ProfilesController < Api::V1::ApplicationController
  before_action :authenticate_user!, only: %i[mypage]

  def show
    @user = User.find_by(name: params[:username])
    @posts = @user.posts.published.order(updated_at: :desc)
    render :show, formats: :json, handlers: 'jbuilder'
  end

  def mypage
    @user = current_user
    render :mypage, formats: :json, handlers: 'jbuilder'
  end
end
