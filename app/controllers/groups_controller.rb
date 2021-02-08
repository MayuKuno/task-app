class GroupsController < ApplicationController
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
    @tasks = Task.where(group_id: @group)
  end

  def destroy
    group = Group.find(params[:id])
    group.destroy
    redirect_to groups_path, notice: 'グループを削除しました'
  end

  
  private
  def group_params
    params.require(:group).permit(:name, user_ids: [])
  end

end