class AddImageUrlToNotification < ActiveRecord::Migration[7.0]
  def change
    add_column :notifications, :image_url, :string
  end
end
