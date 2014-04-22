module UsersHelper

  def link_to_user(user)
    link_to(user.name, controller: :users, action: :units, id: user.id)
  end
   def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
