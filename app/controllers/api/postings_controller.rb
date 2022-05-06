class Api::PostingsController < ApplicationController
  before_action :authenticate_user!, only: ['index']
  def index
    @posts = current_user.posts
    render :index, formats: :json, handlers: 'jbuilder'
  end
end
