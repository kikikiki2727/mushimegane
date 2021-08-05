class Comment < ApplicationRecord
  belongs_to :bug
  has_many :likes, dependent: :destroy

  validates :sentence, presence: true, length: { maximum: 3000 }

  scope :sort_like, -> { includes(:likes).sort { |a, b| b.likes.count <=> a.likes.count } }

  def post_by(current_ip)
    self.global_ip == current_ip
  end

  def liked_by(global_ip)
    Like.find_by(comment_id: self.id, global_ip: global_ip)
  end
end
