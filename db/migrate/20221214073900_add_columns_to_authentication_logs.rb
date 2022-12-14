class AddColumnsToAuthenticationLogs < ActiveRecord::Migration[6.1]
  def change
    add_column :authentication_logs, :path, :string
    add_column :authentication_logs, :action_name, :string
  end
end
