class User < ApplicationRecord
  self.primary_key = 'id'
  has_many :tasks, class_name: 'Task', foreign_key: 'assignee_id'
end
