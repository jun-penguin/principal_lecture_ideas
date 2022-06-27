class Admins::UsersController < Admins::BaseController
  before_action :find_user, only: %i[show edit update destroy]

  def index
    @users = User.all.order(created_at: :desc).page(params[:page])
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to admins_user_path(@user), success: t('defaults.message.updated', item: User.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: User.model_name.human)
      render :edit
    end
  end

  def destroy
    @user.destroy!
    redirect_to admins_users_path, success: t('defaults.message.deleted', item: User.model_name.human)
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :status, :prefecture, :self_introduction)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
