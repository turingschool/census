class UserSerializer < ActiveModel::Serializer
  attributes :first_name, :last_name, :cohort, :image_url

  def image_url
    object.image.url
  end
end
