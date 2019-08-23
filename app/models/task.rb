class Task < ApplicationRecord
  belongs_to :user
  
  validates :user_id, presence: true
  validates :task_name, presence: true, length: { maximum: 50 }
  validates :task_description, presence: true, length: { in: 5..300 }
end
