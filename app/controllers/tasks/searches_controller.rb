class Tasks::SearchesController < ApplicationController
  def index
    # @tasks = Task.search(params[:keyword])
    @tasks = Task.where('taskname LIKE(?)', "%#{params[:keyword]}%")
    # Task.joins(:labels).where('taskname LIKE ? OR color LIKE ?', "%#{search}%", "%#{search}%").uniq

    # @tasks = Task.where('taskname LIKE(?)', "%#{params[:title]}%")
    respond_to do |format|
      format.html
      format.json
    end
  end
end
