class RemoveColumnFromDevices < ActiveRecord::Migration[6.1]
  def change
    remove_column :devices, :device_id
  end
end
