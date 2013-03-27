class Showtask < ActiveRecord::Base
  attr_accessible :shared, :sharer_id, :task_id, :user_id, :sharer, :user, :task
  belongs_to :user
  belongs_to :task
  belongs_to :sharer, :foreign_key => "sharer_id", :class_name => "User"

  scope :with_tasks, includes(:task)
end
