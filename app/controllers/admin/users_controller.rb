class Admin::UsersController < ApplicationController
  before_action :login_required
  before_action :require_admin
  helper_method :sort_column, :sort_direction

  def index
    @users = User.order(sort_column + " " + sort_direction)
  end

  def show
    @user = User.find(params[:id])
  end


  # def new
  #   @user = User.new
  # end

  # def create
  #   @user = User.new(user_params)
  #   if @user.save
  #     if current_user.admin?
  #       redirect_to admin_users_path
  #     else
  #       log_in(@user)
  #         # メールを送りたい時だけ
  #         # UserNotifierMailer.send_signup_email(@user).deliver
  #       redirect_to root_path
  #     end
  #   else
  #     render :new
  #   end
  # end

  # def edit
  #   @user = User.find(params[:id])
  # end

  # def update
  #   @user = User.find(params[:id])
  #   if @user.update(user_params)
  #     redirect_to user_path(@user), notice:"ユーザー「#{@user.username}」を更新しました"
  #   else
  #     render :edit
  #   end
  # end

  def destroy
    @user = User.find(params[:id])
    @admins = User.where(admin: 1).count
    if @user.admin? && @admins <= 1
      redirect_to admin_users_url, alert:"最後の管理者のため削除できません"
    else
      @user.destroy

      redirect_to admin_users_url, notice:"ユーザー「#{@user.username}」を削除しました"
    end
  end




  private

  # def user_params
  #   params.require(:user).permit(:username, :email, :image, :admin, :password, :password_confirmation)
  # end

  def login_required
    redirect_to login_url unless current_user
  end

  def require_admin
    redirect_to root_url unless current_user.admin?
  end


  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "username"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
