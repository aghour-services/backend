class AddUserRefernceToFirms < ActiveRecord::Migration[6.1]
  def change
    add_reference :firms, :user, index: true
  end
end
