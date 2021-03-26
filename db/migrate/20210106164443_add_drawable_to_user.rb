class AddDrawableToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :drawable, :boolean, default: false
  end
end
