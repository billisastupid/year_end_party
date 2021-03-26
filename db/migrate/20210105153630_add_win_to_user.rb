class AddWinToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :win, :boolean, default: false
  end
end
