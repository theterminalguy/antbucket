class User < ActiveRecord::Base
  has_many :bucket_lists, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def login
    update(online: true)
  end

  def logout
    update(online: false)
  end
end
