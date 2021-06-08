class RadarChart < ApplicationRecord
  belongs_to :bug

  validates :capture, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :breeding, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :quickness, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :evil, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :discomfort, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
end
