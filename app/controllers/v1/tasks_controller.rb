class V1::TasksController < ApplicationController
  def index
    @tasks = Task.all.decorate
  end

  # Tasks that have a deadline and are assigned to a user are assumed to be 'doable'.
  def todo
    @tasks = TaskDecorator.decorate_collection Task.getReadyToDoTasks
    render "v1/tasks/index"
  end

  # Tasks that are not assigned to anyone. Who will do them? No one knows!
  def unassigned
    @tasks = TaskDecorator.decorate_collection Task.getUnassignedTasks
    render "v1/tasks/index"
  end

  # Tasks without a due date set.
  def unplanned
    @tasks = TaskDecorator.decorate_collection Task.getUnplannedTasks
    render "v1/tasks/index"
  end
end
