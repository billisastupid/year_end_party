class CreatePrizes < ActiveRecord::Migration[6.0]
  def change
    create_table :prizes do |t|
      t.string :title
      t.string :content
      t.integer :quantity
      t.integer :fulfilled_quantity, default: 0
      t.boolean :drawable, default: true

      t.timestamps
    end
  end
end
