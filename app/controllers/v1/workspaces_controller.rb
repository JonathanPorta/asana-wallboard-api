class WorkspacesController < ApplicationController
  def index
    asana = AsanaApi.new

    @workspaces = asana.workspaces
    render json: @workspaces
  end
end
