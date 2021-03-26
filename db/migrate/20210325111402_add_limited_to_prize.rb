class AddLimitedToPrize < ActiveRecord::Migration[6.0]
  def change
    add_column :prizes, :limited, :boolean, default: true
  end
end
