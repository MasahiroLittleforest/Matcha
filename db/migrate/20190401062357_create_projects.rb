class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      
      t.string :title
      t.text :content
      t.references :user, foreign_key: true
      t.datetime :deadline
      t.integer :recruitment_numbers
      t.boolean :all_or_nothing
      t.boolean :call_off
      t.references :project_category, foreign_key: true
      t.string :image
      
      t.timestamps
    end
  end
end
