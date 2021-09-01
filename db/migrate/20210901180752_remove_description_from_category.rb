class RemoveDescriptionFromCategory < ActiveRecord::Migration[6.1]
  def change
    remove_column :categories, :description
  end
end
