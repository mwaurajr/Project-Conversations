class StatusChange < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :previous_status, presence: true
  validates :new_status, presence: true
end
