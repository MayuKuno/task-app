class UsersController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :login_required, except: [:new, :create]
  before_action :correct_user,   only: [:edit, :update, :show]



  def index
    return nil if params[:keyword] == ""
    @users = User.where(['username LIKE ?', "%#{params[:keyword]}%"] ).where.not(id: current_user.id).limit(10)
    respond_to do |format|
      format.html
      format.json
    end
  end
  

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      if logged_in?
        redirect_to admin_users_path
      else
        log_in(@user)
          # メールを送りたい時だけ
          # UserNotifierMailer.send_signup_email(@user).deliver
        redirect_to root_path
      end
    else
      render :new
    end
  end


  def edit
    

  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice:"ユーザー「#{@user.username}」を更新しました"
    else
      render :edit
    end
  end



  def show
    # @user = User.find(params[:id])
    @tasks = Task.where(group_id: nil).where(user_id: @user.id).order(sort_column + " " + sort_direction)
  end




  private

  
  def user_params
    params.require(:user).permit(:username, :email, :image, :admin, :password, :password_confirmation)
  end

  def login_required
    redirect_to login_url unless current_user
  end

  def correct_user
    @user = User.find(params[:id])
    @group = Group.find(params[:id])
    redirect_to(root_path) unless current_user?(@user) || current_user.admin?
    if @group
      redirect_to root_path unless current_user.groups.include?(@group)
    end
  end
 

  def sort_column
    Task.column_names.include?(params[:sort]) ? params[:sort] : "taskname"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
