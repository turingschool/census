class UserSerializer < ActiveModel::Serializer
  attributes :id,
             :first_name,
             :last_name,
             :cohort,
             :image_url,
             :email,
             :slack,
             :stackoverflow,
             :linked_in,
             :git_hub,
             :twitter,
             :roles,
             :groups

  def image_url
    url = object.image.url
    root_url = instance_options[:root_url] || ""

    if !url.include?("http") && url.include?("missing.png")
      root_url + url
    else
      url
    end
  end

  def groups
    object.groups.map do |group|
      group.name
    end
  end

end
