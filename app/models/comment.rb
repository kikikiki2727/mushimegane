class Comment < ApplicationRecord
  belongs_to :bug
  belongs_to :user

  validates :sentence, presence: true, length: { maximum: 3_000 }
end
