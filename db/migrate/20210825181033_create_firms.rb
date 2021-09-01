class CreateFirms < ActiveRecord::Migration[6.1]
  def change
    create_table :firms do |t|
      t.string :name, index: true
      t.string :description
      t.string :address
      t.string :phone_number
      t.string :email
      t.string :fb_page

      t.references :category
      t.timestamps
    end
  end
end
