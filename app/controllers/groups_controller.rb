class GroupsController < ApplicationController
  helper_method :sort_column, :sort_direction

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
    @tasks = Task.where(group_id: @group).where(user_id: current_user.id).order(sort_column + " " + sort_direction).page(params[:page]).per(10)


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

  
  private
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
