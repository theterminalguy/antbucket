class UserSerializer < ActiveModel::Serializer
  attributes :email, :created_at, :updated_at

  has_many :bucket_list
end
