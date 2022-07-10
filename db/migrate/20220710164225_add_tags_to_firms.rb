class AddTagsToFirms < ActiveRecord::Migration[6.1]
  def change
    add_column :firms, :tags, :string
  end
end
