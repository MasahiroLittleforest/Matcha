class ChangeCancelInApplikations < ActiveRecord::Migration[5.0]
  def change
    change_column :applikations, :cancel, :boolean, default: false, null: false
  end
end
