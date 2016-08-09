class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users, id: false do |t|
      t.string :id, null: false
      t.string :name
      t.string :email
      t.string :photo

      t.timestamps
    end
    add_index :users, :id, unique: true
  end
end
