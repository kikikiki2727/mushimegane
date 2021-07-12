class RadarChart < ApplicationRecord
  belongs_to :bug

  validates :capture, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
  validates :breeding, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
  validates :prevention_difficulty, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
  validates :injury, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
  validates :discomfort, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
  
end
