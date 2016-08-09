require 'asana'

class AsanaApi
  def taskFields
    ['id','assignee','assignee_status','created_at','completed','completed_at','due_on','due_at','external','hearted','followers','hearts','modified_at','name','notes','num_hearts','projects','parent','workspace','memberships']
  end

  def projectFields
    ['team','workspace','notes','color','followers','members','public','archived','modified_at','created_at','due_date','current_status','owner','id','name']
  end

  def userFields
    ['id','name','email','photo']
  end

  def initialize(api_key: nil, workspace_id: nil)
    @api_key = api_key || Rails.application.secrets.asana_api_key
    @workspace_id = workspace_id || Rails.application.secrets.asana_workspace_id

    @client = Asana::Client.new do |c|
      c.authentication :access_token, @api_key
    end
  end

  def workspaces
    @client.workspaces.find_all
  end

  def users
    getCollectionAsArray usersByWorkspaceId(@workspace_id)
  end

  def projects
    projects = []
    workspaces.each do |w|
      projects.concat getCollectionAsArray projectsByWorkspaceId(w.id)
    end
    projects
  end

  def tasks
    tasks = []
    projects.each do |p|
      tasks.concat getCollectionAsArray tasksByProjectId(p.id)
    end
    tasks
  end

  def usersByWorkspaceId(workspace_id)
    @client.users.find_all workspace: workspace_id, options: {fields: userFields}
  end

  def projectsByWorkspaceId(workspace_id)
    @client.projects.find_all workspace: workspace_id, options: {fields: projectFields}
  end

  def tasksByProjectId(project_id)
    @client.tasks.find_by_project projectId: project_id, options: {fields: taskFields}
  end

  private
  def getCollectionAsArray(collection)
    items = []
    collection.each do |i|
      items.push i
    end
    items
  end
end
