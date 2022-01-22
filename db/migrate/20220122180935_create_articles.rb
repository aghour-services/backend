class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.text :description
      t.references :user, index: true
      t.integer :status, index: true
      t.timestamps
    end
  end
end
