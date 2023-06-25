class CreateAvatars < ActiveRecord::Migration[7.0]
  def change
    create_table :avatars do |t|
      t.string :resource_id
      t.string :resource_type
      t.string :url
      t.text :raw_response
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
