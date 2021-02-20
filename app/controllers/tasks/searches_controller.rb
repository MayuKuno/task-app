class Tasks::SearchesController < ApplicationController
  def index
    @tasks = Task.rank(:row_order).search(params[:keyword])
      respond_to do |format|
      format.html
      format.json
    end
  end

  def sort
    task = Task.find(params[:task_id])
    task.update(task_params)
    render body: nil
  end

  private
  def task_params
    params.require(:task).permit(:taskname, :description, :priority, :status,:image ,:deadline,:group_id, :row_order_position, label_ids: []).merge(user_id: current_user.id)
  end

end
