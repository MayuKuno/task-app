class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :show]


  def index
    @tasks = Task.all
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
    params.require(:task).permit(:taskname, :description, :priority, :status,:deadline).merge(user_id: current_user.id)
  end

  def set_task
    @task = Task.find(params[:id]) 
  end


end
