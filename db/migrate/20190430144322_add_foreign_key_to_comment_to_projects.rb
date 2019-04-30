class AddForeignKeyToCommentToProjects < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :comment_to_projects, :projects
    add_foreign_key :comment_to_projects, :projects, on_delete: :cascade
  end
end
