class Comment < ApplicationRecord
  belongs_to :bug
  belongs_to :user
  has_many :likes, dependent: :destroy

  validates :sentence, presence: true, length: { maximum: 3_000 }
end
