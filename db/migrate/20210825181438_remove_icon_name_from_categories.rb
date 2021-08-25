class RemoveIconNameFromCategories < ActiveRecord::Migration[6.1]
  def change
    remove_column :categories, :icon_name
  end
end
