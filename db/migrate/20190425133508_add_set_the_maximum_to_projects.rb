class AddSetTheMaximumToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :set_the_maximum, :boolean, default: false, null: false
  end
end
