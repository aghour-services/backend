class CreateAuthenticationLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :authentication_logs do |t|
      t.string :user_token

      t.timestamps
    end
  end
end
