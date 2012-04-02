module UsersHelper
  
  def gravatar_for(user, options = { :size => 48 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "http://gravatar.com/avatar/#{gravatar_id}.png?size=#{size}"
    image_tag(gravatar_url, alt: user.username, width:"#{size}px", height:"#{size}px")  
  end

  def header_gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "http://gravatar.com/avatar/#{gravatar_id}.png?size=20"
    image_tag(gravatar_url, alt: user.username, class: "gravatar-header")  
  end
  
  
  def current_user?(user)
    user == current_user
  end
  
end
