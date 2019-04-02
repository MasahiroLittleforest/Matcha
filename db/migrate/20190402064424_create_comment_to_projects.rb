class CreateCommentToProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :comment_to_projects do |t|
      
      t.text :comment
      t.references :user, foreign_key: true
      t.references :project, foreign_key: true
      
      t.timestamps
    end
  end
end
