class AddIndexToDeviceId < ActiveRecord::Migration[6.1]
  def change
    add_index :devices, :device_id, unique: true
  end
end
