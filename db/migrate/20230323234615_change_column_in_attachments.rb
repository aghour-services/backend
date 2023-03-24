class ChangeColumnInAttachments < ActiveRecord::Migration[7.0]
  def change
    rename_column :attachments, :image, :resource_id
  end
end
