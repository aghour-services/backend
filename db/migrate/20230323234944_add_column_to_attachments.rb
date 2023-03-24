class AddColumnToAttachments < ActiveRecord::Migration[7.0]
  def change
    add_column :attachments, :resource_type, :string
    add_column :attachments, :raw_response, :text
  end
end
