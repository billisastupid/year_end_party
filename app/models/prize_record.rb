class PrizeRecord < ApplicationRecord
  belongs_to :prize
  belongs_to :user
end
