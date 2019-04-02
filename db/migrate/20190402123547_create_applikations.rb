class CreateApplikations < ActiveRecord::Migration[5.0]
  def change
    create_table :applikations do |t|
      
      t.references :user, foreign_key: true
      t.references :project, foreign_key: true
      t.boolean :cancel
      t.datetime :canceled_at
      
      t.timestamps
      
      t.index [:user_id, :project_id], unique: true
    end
  end
end
