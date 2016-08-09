class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks, id: false do |t|
      t.string :id, null: false
      t.datetime :created_at
      t.datetime :modified_at
      t.string :name
      t.text :notes
      t.boolean :completed
      t.string :assignee_status
      t.datetime :completed_at
      t.datetime :due_on
      t.datetime :due_at
      t.string :workspace_id
      t.integer :num_hearts
      t.string :assignee_id
      t.string :parent_id
      t.boolean :hearted

      t.timestamps
    end
    add_index :tasks, :workspace_id
    add_index :tasks, :assignee_id
    add_index :tasks, :parent_id
    add_index :tasks, :id, unique: true
  end
end
