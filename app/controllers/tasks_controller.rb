class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :show]
  before_action :login_required, except: [:index, :search]
  helper_method :sort_column, :sort_direction

  def index
    @tasks = Task.includes(:user).order(sort_column + " " + sort_direction).page(params[:page]).per(5)
  end

  def show
  end

  def new
    @task = Task.new

  end

  def create
    @task = Task.new(task_params)
    if @task.save
      
      flash[:notice] = "The task has been saved!"
      redirect_to tasks_path
    else
      flash[:alert] = "Please try it again"
      render :new
    end
  end

  def edit
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:notice] = "The task has been updated!"
      redirect_to tasks_path
    else
      flash[:alert] = "Please try it again"
      render :edit
    end
  end

  def destroy
    task = Task.find(params[:id])
    if task.destroy
      flash[:notice] = "The task has been deleted!"
      redirect_to tasks_path
    end
  end



  private
  def task_params
    params.require(:task).permit(:taskname, :description, :priority, :status,:image ,:deadline, label_ids: []).merge(user_id: current_user.id)
  end

  def set_task
    @task = Task.find(params[:id]) 
  end

  def login_required
    redirect_to login_url unless current_user
  end

  def sort_column
    Task.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
