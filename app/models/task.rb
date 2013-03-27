class Task < ActiveRecord::Base
  attr_accessible :description, :title

  has_many :showtasks, :dependent => :destroy
  has_many :users, :through => :showtasks

  def share(to_email, by_user)
    user = User.find_by_email(to_email)
    if user
      unless user.tasks.include?(self)
        Showtask.create(
          :task => self,
          :user => user,
          :sharer => by_user,
          :shared => true
        )
      else
        error = "This user (#{to_email}) already has access to this task"
      end
    else
      error = "User with such email not found"
    end
    error
  end
end
