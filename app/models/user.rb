class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :bugs, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_comments, through: :likes, source: :comment

  validates :password, length: { minimum: 8 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: { case_sensitive: true }, presence: true
  validates :name, presence: true, length: { maximum: 30 }

  def like_comment(comment)
    liked_comments << comment
  end

  def unlike_comment(comment)
    liked_comments.destroy(comment)
  end

  def like_comment?(comment)
    liked_comments.include?(comment)
  end

  def own?(comment)
    id == comment.user_id
  end
end
