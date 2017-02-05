class GroupSerializer < ActiveModel::Serializer
  attributes :id, :name, :member_count

  def member_count
    object.member_count
  end

end
