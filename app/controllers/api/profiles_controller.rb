class Api::ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(current_user.id)
    render :show, formats: :json, handlers: 'jbuilder'
  end
end
