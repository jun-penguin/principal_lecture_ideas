class Admins::BaseController < ApplicationController
  layout 'admins/layouts/application'
  # before_action :authorize
  before_action :authenticate_admin!
  # skip_before_action :authenticate_user!
end
