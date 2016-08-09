class TasksController < ApplicationController
  def index
    asana = AsanaApi.new

    @tasks = asana.tasks
    render json: @tasks
  end
end
