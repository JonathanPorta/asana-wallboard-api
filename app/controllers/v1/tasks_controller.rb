class V1::TasksController < ApplicationController
  def index
    @tasks = Task.all.decorate
  end

  def todo
    @tasks = Task.where(completed: false).where.not(due_on: nil).order(due_on: :asc).decorate
    render "v1/tasks/index"
  end

  def unassigned
    @tasks = Task.where(completed: false).where.not(due_on: nil).where(assignee: nil).order(due_on: :asc).decorate
    render "v1/tasks/index"
  end

  def unplanned
    @tasks = Task.where(completed: false).where(due_on: nil).order(created_at: :desc).decorate
    render "v1/tasks/index"
  end
end
