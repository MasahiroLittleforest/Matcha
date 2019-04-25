class RemoveSetTheMaximumFromProjects < ActiveRecord::Migration[5.0]
  def change
    remove_column :projects, :set_the_maximum, :boolean
  end
end
