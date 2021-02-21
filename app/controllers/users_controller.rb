class UsersController < ApplicationController
  helper_method :sort_column, :sort_direction

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
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice:"ユーザー「#{@user.username}」を更新しました"
    else
      render :edit
    end
  end



  def show
    @user = User.find(params[:id])
    @tasks = Task.where(group_id: nil).where(user_id: @user.id).order(sort_column + " " + sort_direction)
  end




  private

  def user_params
    params.require(:user).permit(:username, :email, :image, :admin, :password, :password_confirmation)
  end

  def sort_column
    Task.column_names.include?(params[:sort]) ? params[:sort] : "taskname"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
