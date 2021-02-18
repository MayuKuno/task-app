class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :show]
  before_action :set_group, only: [:new, :create, :edit, :update]
  
  before_action :login_required, except: [:index, :search]
  helper_method :sort_column, :sort_direction

  def index
    if logged_in?
      @tasks = Task.includes(:user).order(sort_column + " " + sort_direction).where(group_id: nil).where(user_id: current_user.id).rank(:row_order).page(params[:page]).per(10)
      tasks = Task.where(user_id: current_user.id).where(group_id: nil)
      
      gon.label  = []
      tasks.each do |task|
        task.labels.each do |label_id|
          gon.label << label_id.color
        end
      end

      alltasks = Task.where(user_id: current_user.id)
      gon.statu = []
      alltasks.each do |task|
        gon.statu << task.status
      end
      
    else
      @tasks = Task.includes(:user).order(sort_column + " " + sort_direction).where(group_id: nil).rank(:row_order).page(params[:page]).per(5)
    end

    respond_to do |format|
      format.html
      format.csv {send_data @tasks.generate_csv, filename: "tasks-#{Time.zone.now.strftime('%Y%m%d%S')}.csv" }
    end


    labels = Label.all
    gon.data = []
    labels.each do |label|
      gon.data << label.color
    end





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
      if @group
        redirect_to group_path(@group)
      else
        redirect_to tasks_path
      end
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
      if @group
        redirect_to group_path(@group)
      else
        redirect_to tasks_path
      end

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

  def import
    current_user.tasks.import(params[:file])
    if params[:file].present?
      redirect_to tasks_path, notice:"タスクをインポートしました"
    else
      redirect_to tasks_path, alert:"ファイルが選択されていません"
    end
  end


  def sort
    task = Task.find(params[:task_id])
    task.update(task_params)
    render body: nil
  end

  def calendar
    @tasks = Task.includes(:user).where(user_id: current_user.id)
    gon.groups = Group.all
    gon.tasks = @tasks

  end

  private
  def task_params
    params.require(:task).permit(:taskname, :description, :priority, :status,:image ,:deadline,:group_id, :row_order_position, label_ids: []).merge(user_id: current_user.id)
  end

  def set_task
    @task = Task.find(params[:id]) 
  end

  def set_group
    if params[:group_id]
      @group = Group.find(params[:group_id]) 
    end
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
