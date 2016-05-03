class BucketList < ActiveRecord::Base
  belongs_to :user 
  validates_uniqueness_of :name 
  validates_presence_of :name 
end
