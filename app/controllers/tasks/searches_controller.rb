class Tasks::SearchesController < ApplicationController
  def index
    @tasks = Task.search(params[:keyword])
  end
end
