class AddStatusToFirms < ActiveRecord::Migration[6.1]
  def change
    add_column :firms, :status, :integer, default: 0, null: false, index: true

    Firm.update_all(status: :published)
  end
end
