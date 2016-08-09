class Task < ApplicationRecord
  self.primary_key = 'id'
  has_many :sub_tasks, class_name: 'Task', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Task'
  belongs_to :assignee, class_name: 'User'
  has_and_belongs_to_many :projects

  # Tasks that have a due date and are assigned to a user are considered actionable.
  def self.getReadyToDoTasks
    where(completed: false).where.not(due_on: nil).where.not(assignee: nil).order(due_on: :asc, due_at: :asc)
  end

  def self.getUnassignedTasks
    where(completed: false).where.not(due_on: nil).where(assignee: nil).order(due_on: :asc, due_at: :asc)
  end

  # Tasks that lack a due date are considered unplanned.
  def self.getUnplannedTasks
    where(completed: false).where(due_on: nil).order(created_at: :desc)
  end
end
