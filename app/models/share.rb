class Share < ActiveRecord::Base
  attr_accessible :shared_by_user_id, :shared_to_user_id, :task_id

  belongs_to :task
  belongs_to :shared_by_user, :class_name => "User", :foreign_key => "shared_by_user_id"
  belongs_to :shared_to_user, :class_name => "User", :foreign_key => "shared_to_user_id"
end
