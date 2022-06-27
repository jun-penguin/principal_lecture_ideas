class Api::V1::ProfilesController < Api::V1::ApplicationController
  before_action :authenticate_user!, only: %i[mypage]

  def mypage
    @user = User.find(current_user.id)
    render :mypage, formats: :json, handlers: 'jbuilder'
  end

  def show
    @user = User.find_by(name: params[:username])
    @posts = @user.posts.published
    render :show, formats: :json, handlers: 'jbuilder'
  end
end
