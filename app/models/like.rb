class Like < ApplicationRecord
  belongs_to :comment

  validates :comment, uniqueness: { scope: :global_ip }
end
