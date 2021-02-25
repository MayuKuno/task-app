class GroupsController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :login_required
  before_action :correct_group,   only: [:edit, :update, :show]


  def index
    @groups = Group.all


  end

  def new
    @group = Group.new
    @group.users << current_user

    # @group = Group.find(params[:group_id])
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to group_path(@group), notice: 'グループを作成しました'
    else
      render :new
    end
  end


  def edit
    @group = Group.find(params[:id])
  end


  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_path(@group), notice: 'グループを更新しました'
    else
      render :edit
    end
  end

  def show
    @group = Group.find(params[:id])
    @tasks = Task.where(group_id: @group).order(sort_column + " " + sort_direction).page(params[:page]).per(10)
    gon.group  = @group

    #For graph
    labels = Label.all
    gon.data = []
    labels.each do |label|
      gon.data << label.color
    end

    gon.label  = []
    @tasks.each do |task|
      task.labels.each do |label_id|
        gon.label << label_id.color
      end
    end

    gon.statu = []
    @tasks.each do |task|
      gon.statu << task.status
    end
    
    #For CSV
    respond_to do |format|
      format.html
      format.csv {send_data @tasks.generate_csv, filename: "tasks-#{Time.zone.now.strftime('%Y%m%d%S')}.csv" }
    end

    #For calendar
    gon.groups = Group.all
    gon.tasks = @tasks
    

  end

  def destroy
    group = Group.find(params[:id])
    group.destroy
    redirect_to groups_path, notice: 'グループを削除しました'
  end

  def import
    if params[:file].present?
      current_user.tasks.import(params[:file])
      flash[:notice] = 'タスクをインポートしました'
      redirect_back(fallback_location: groups_path)
    else
      flash[:alert] = 'ファイルが選択されていません'
      redirect_back(fallback_location: groups_path)
    end
  end

  def sort
    task = Task.find(params[:task_id])
    task.update(task_params)
    render body: nil
  end

  def search
    @group = Group.find(params[:id])
    @tasks = Task.where(group_id: @group).search(params[:keyword])
    respond_to do |format|
      format.html
      format.json
    end
  end

  # def done
  #   @task = Task.find(params[:id]) 
  #   @task.update(status: 2)
  #   @tasks = Task.where(group_id: @group).order(sort_column + " " + sort_direction).page(params[:page]).per(10)
  # end
  
  private
  
  def login_required
    redirect_to login_url unless current_user
  end

  def correct_group
    @group = Group.find(params[:id])
    redirect_to root_path unless current_user.groups.include?(@group)

  end


  def group_params
    params.require(:group).permit(:name, user_ids: [])
  end

  def sort_column
    Task.column_names.include?(params[:sort]) ? params[:sort] : "taskname"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
