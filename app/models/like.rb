class Like < ApplicationRecord
  belongs_to :user
  belongs_to :comment

  validates :user_id, uniqueness: {scope: :comment_id}

  after_create :notify_comment_author

  private

  def notify_comment_author
    return if user == comment.user

    LikeNotification.with(like: self, comment: comment).deliver_later(comment.user)
  end
end
