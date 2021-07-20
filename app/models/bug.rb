class Bug < ApplicationRecord
  belongs_to :user
  has_one :radar_chart, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_one_attached :image

  enum size: { extra_small: 1, small: 2, medium: 3, large: 4 }
  enum color: { black: 1, brown: 2, gray: 3, white: 4, red: 5, orange: 6, yellow: 7, green: 8 }
  enum season: { spring: 1, summer: 2, autumn: 3, winter: 4 }

  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :feature, length: { maximum: 3_000 }
  validates :approach, length: { maximum: 3_000 }
  validates :prevention, length: { maximum: 3_000 }
  validates :harm, length: { maximum: 3_000 }

  scope :high_chart, ->(column) { joins(:radar_chart).where(radar_charts: { column => [8, 9, 10] }) }
  scope :normal_chart, ->(column) { joins(:radar_chart).where(radar_charts: { column => [4, 5, 6, 7] }) }
  scope :low_chart, ->(column) { joins(:radar_chart).where(radar_charts: { column => [1, 2, 3] }) }
end
