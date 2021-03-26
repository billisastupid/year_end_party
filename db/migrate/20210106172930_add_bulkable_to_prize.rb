class AddBulkableToPrize < ActiveRecord::Migration[6.0]
  def change
    add_column :prizes, :bulk, :integer, default: 1
    add_column :prizes, :key, :string
    add_index :prizes, :key, unique: true
  end
end
