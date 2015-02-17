class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :user_id
      t.integer :project_id
      t.text :extra

      t.timestamps null: false
    end
    add_index :memberships, [:user_id, :project_id]
  end
end
