class CreateDevices < ActiveRecord::Migration[6.1]
  def change
    create_table :devices do |t|
      t.string :device_id
      t.string :token
      t.datetime :last_usage_time
      t.timestamps
    end
  end
end
