class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects, id: false do |t|
      t.string :id, null: false
      t.string :workspace_id
      t.text :notes
      t.string :name

      t.timestamps
    end
    add_index :projects, :workspace_id
    add_index :projects, :id, unique: true

    create_table :projects_tasks, id: false do |t|
      t.string "project_id"
      t.string "task_id"
    end
    add_index :projects_tasks, :project_id
    add_index :projects_tasks, :task_id
  end
end
