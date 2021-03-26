class CreatePrizeRecord < ActiveRecord::Migration[6.0]
  def change
    create_table :prize_records do |t|
      t.belongs_to :prize
      t.belongs_to :user
      t.string :remark
      t.boolean :active , default: true

      t.timestamps
    end
  end
end
