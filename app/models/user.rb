class User < ActiveRecord::Base 
  has_many :bucket_lists, dependent: :destroy 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
