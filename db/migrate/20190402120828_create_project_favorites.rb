class CreateProjectFavorites < ActiveRecord::Migration[5.0]
  def change
    create_table :project_favorites do |t|

      t.timestamps
    end
  end
end
