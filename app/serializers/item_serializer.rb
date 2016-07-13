class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :done, :created_at
end
