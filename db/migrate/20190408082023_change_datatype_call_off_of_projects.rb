class ChangeDatatypeCallOffOfProjects < ActiveRecord::Migration[5.0]
  def change
    change_column :projects, :call_off, :boolean, default: false, null: false
  end
end
