class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_many :projects, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :status_changes, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :notifications, as: :recipient, dependent: :destroy, class_name: "Notification"

  def name_or_email
    name.presence || email.split("@").first
  end
end
