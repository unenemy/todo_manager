class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  has_many :tasks
  has_many :with_me_shares, :foreign_key => "shared_to_user_id", :class_name => "Share"
  has_many :with_me_shares_tasks, :through => :with_me_shares, :class_name => "Task", :source => :task
end
