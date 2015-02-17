class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name

      t.timestamps null: false
    end
    add_index :projects, [:name], :unique => true
  end
end
