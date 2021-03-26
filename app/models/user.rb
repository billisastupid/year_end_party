class User < ApplicationRecord
  scope :active, -> { where(active: true) }
  scope :not_win_yet, -> { where(win: false) }
  scope :drawable, -> { where(drawable: true) }
end
