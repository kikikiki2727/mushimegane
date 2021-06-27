class Like < ApplicationRecord
  belongs_to :user
  belongs_to :comment

  validates :comment, uniqueness: { scope: :user_id }
end
