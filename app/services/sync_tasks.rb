class SyncTasks
  def initialize
    @asana_api = AsanaApi.new
  end

  def call
    tasks = @asana_api.tasks.map do |d|
      # Extract the persisted fields
      puts "d.workspace: ", d.workspace
      puts "d.assignee: ", d.assignee
      puts "d.parent: ", d.parent
      puts "d.memberships: ", d.parent

      assignee = nil
      if d.assignee
        puts 'Looking up assignee', d.assignee['id']
        assignee = User.find d.assignee['id']
        puts 'Found assignee: ', assignee
      end

      task_data = {
        id: d.id,
        created_at: d.created_at,
        modified_at: d.modified_at,
        name: d.name,
        notes: d.notes,
        completed: d.completed,
        assignee_status: d.assignee_status,
        completed_at: d.completed_at,
        due_on: d.due_on,
        due_at: d.due_at,
        num_hearts: d.num_hearts,
        hearted: d.hearted,
        workspace_id: (d.workspace ? "#{d.workspace[:id]}" : nil),
        assignee: assignee,
        parent_id: (d.parent ? "#{d.parent['id']}" : nil)
      }

      task = Task.find_by(id: task_data[:id]) || Task.new(task_data)

      task.attributes = task_data

      # if task.persisted?
      #   task.update task_data # update if task is already in the database
      #   Rails.logger.info "Updated Task: #{ task.id }, #{ task.name }"
      # else
      task.save validate: false # save if the task is new to the database
      Rails.logger.info "Saving Task: #{ task.id }, #{ task.name }"
      # end

      task
    end

    # Remove tasks that are no longer in the API
    Task.where.not(id: tasks.map(&:id)).destroy_all.each do |removed|
      Rails.logger.info "Removed Task: #{ removed.id }, #{ removed.name }"
    end

    tasks
  end
end
