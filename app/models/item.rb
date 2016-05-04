class Item < ActiveRecord::Base
  belongs_to :bucket_list
  validates :name, uniqueness: true, presence: true 
end
