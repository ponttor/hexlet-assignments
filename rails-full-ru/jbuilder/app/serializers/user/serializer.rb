class User::Serializer < ActiveModel::Serializer
  attributes :id, :email, :address, :full_name

  has_many :posts,
    serializer: Post::Serializer

  def full_name
    "#{object.first_name} #{object.last_name}"
  end
end