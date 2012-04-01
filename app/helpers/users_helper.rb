module UsersHelper
  
  def gravatar_for(user, options = { :size => 50, :round => false })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "http://gravatar.com/avatar/#{gravatar_id}.png?size=#{size}"
    image_tag(gravatar_url, alt: user.username, width:"#{size}", height:"#{size}")  
  end
  
  def current_user?(user)
    user == current_user
  end
  
end
