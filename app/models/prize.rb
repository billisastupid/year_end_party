class Prize < ApplicationRecord
  scope :drawable, -> { where(drawable: true) }
  has_many :prize_records
  has_many :users, through: :prize_records
end
