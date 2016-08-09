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

      # Lookup the User model that this task is assigned to, if applicable.
      assignee = nil
      if d.assignee
        assignee = User.find d.assignee['id']
        Rails.logger.info "Found Existing User: #{ assignee.id }, #{ assignee.name }"
      end

      # Lookup any Project models that this task is a part of.
      projects = []
      if d.projects
        d.projects.each do |p|
          # Find the project referenced, or lazily create it
          # We do this because some projects are not in scope of the /projects
          # api call but they are in scope here, for some reason... o.O
          model = Project.find_by(id: p.id) || Project.new(id: p.id, name: p.name)
          if !model.persisted?
            model.save!
            Rails.logger.info "Created a new Project: #{ model.id }, #{ model.name }"
          else
            Rails.logger.info "Found Existing Project: #{ model.id }, #{ model.name }"
          end
          projects.push model
        end
        Rails.logger.info "The Task '#{ d.name }' will be added to #{ projects.length } projects."
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
        workspace_id: (d.workspace ? d.workspace['id'] : nil),
        assignee: assignee,
        projects: projects,
        parent_id: (d.parent ? d.parent['id'] : nil)
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
