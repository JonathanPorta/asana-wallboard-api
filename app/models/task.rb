class Task < ApplicationRecord
    self.primary_key = 'id'
    has_many :sub_tasks, class_name: 'Task', foreign_key: 'parent_id'
    belongs_to :parent, class_name: 'Task'
    belongs_to :assignee, class_name: 'User'
    has_and_belongs_to_many :projects
end
