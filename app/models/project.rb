class Project < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :status_changes, dependent: :destroy

  STATUSES = ["Planning", "In Progress", "Review", "Completed"]

  validates :title, presence: true
  validates :status, inclusion: {in: STATUSES}

  def conversation_items
    (comments.includes(:user, :likes) + status_changes.includes(:user)).sort_by(&:created_at)
  end

  def update_status(new_status, current_user)
    return if status == new_status

    previous = status
    if update(status: new_status)
      status_changes.create(
        previous_status: previous,
        new_status: new_status,
        user: current_user
      )

      # Notify project members about status change
      users_to_notify = comments.map(&:user).uniq - [current_user]
      users_to_notify.each do |user|
        StatusChangeNotification.with(
          project: self,
          status_change: status_changes.last
        ).deliver_later(user)
      end

      true
    else
      false
    end
  end
end
