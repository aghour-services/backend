class RemoveColumnFromArticles < ActiveRecord::Migration[7.0]
  def change
    remove_column :articles, :attachment_url
  end
end
