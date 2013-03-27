class Task < ActiveRecord::Base
  attr_accessible :description, :title

  has_many :showtasks, :dependent => :destroy
  has_many :users, :through => :showtasks
end
