class CreateAvatars < ActiveRecord::Migration[7.0]
  def change
    create_table :avatars do |t|
      t.string :avatar_id
      t.string :avatar_type
      t.string :avatar_url
      t.text :raw_response
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
