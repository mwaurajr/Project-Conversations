class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :project
  belongs_to :parent, class_name: "Comment", optional: true

  has_many :replies, class_name: "Comment", foreign_key: "parent_id", dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one_attached :image

  validates :content, presence: true, unless: -> { image.attached? }

  after_create :notify_users

  def root_comment?
    parent_id.nil?
  end

  def liked_by?(user)
    likes.where(user: user).exists?
  end

  private

  def notify_users
    return if project.nil?

    users_to_notify = project.comments.map(&:user).uniq - [user]
    users_to_notify.each do |recipient|
      CommentNotification.with(comment: self, project: project).deliver_later(recipient)
    end
  end
end
