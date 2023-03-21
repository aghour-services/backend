class RemoveImageUrlFromArticles < ActiveRecord::Migration[7.0]
  def change
    remove_column :articles, :image_url
  end
end
