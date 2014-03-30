module UsersHelper

  def link_to_user(user)
    link_to(user.name, controller: :users, action: :units, id: user.id)
  end
end
