class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.string :title
      t.text :body
      t.references :notifiable, polymorphic: true

      t.timestamps
    end
  end
end
