class AddUserIdToDevice < ActiveRecord::Migration[7.0]
  def change
    add_reference :devices, :user, foreign_key: true
  end
end
