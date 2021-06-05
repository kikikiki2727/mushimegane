class Bug < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :feature, length: { maximum: 3000 }
  validates :approach, length: { maximum: 3000 }
  validates :prevention, length: { maximum: 3000 }
  validates :harm, length: { maximum: 3000 }
  validates :size, presence: true
  validates :color, presence: true
  validates :season, presence: true

  enum size: {  unknown_size: 0, extra_small: 1, small: 2, medium: 3, large: 4, extra_large: 5 }
  enum color: { unknown_color: 0, brack: 1, brown: 2, gray: 3, white: 4, red: 5, orange: 6, yellow: 7, green: 8 }
  enum season: { unknown_seazon: 0, spring: 1, summer: 2, autumn: 3, winter: 4 }
end
