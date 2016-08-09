class SyncProjects
  def initialize
    @asana_api = AsanaApi.new
  end

  def call
    projects = @asana_api.projects.map do |d|
      # Extract the persisted fields
      project_data = {
        id: d.id,
        name: d.name,
        notes: d.notes,
        workspace_id: (d.workspace ? d.workspace['id'] : nil),
      }

      project = Project.find_by(id: project_data[:id]) || Project.new(project_data)

      if project.persisted?
        project.update! project_data # update if project is already in the database
        Rails.logger.info "Updated Project: #{ project.id }, #{ project.name }"
      else
        project.save! # save if the project is new to the database
        Rails.logger.info "Inserted Project: #{ project.id }, #{ project.name }"
      end

      project
    end

    # Remove projects that are no longer in the API
    Project.where.not(id: projects.map(&:id)).destroy_all.each do |removed|
      Rails.logger.info "Removed Project: #{ removed.id }, #{ removed.name }"
    end

    projects
  end
end
