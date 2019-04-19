class ChangeDatatypeAllOrNothingOfProjects < ActiveRecord::Migration[5.0]
  def change
    change_column :projects, :all_or_nothing, :boolean, default: false, null: false
  end
end