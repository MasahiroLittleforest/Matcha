class AddForeignKeyToApplikations < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :applikations, :projects
    add_foreign_key :applikations, :projects, on_delete: :cascade
  end
end
