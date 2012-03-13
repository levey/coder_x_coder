module UsersHelper
  
  def gravatar_for(user, options = { :size => 50, :round => false })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "http://gravatar.com/avatar/#{gravatar_id}.png?size=#{options[:size]}"
    avatar_class = options[:round] ? "gravatar-header" : "gravatar"
    image_tag(gravatar_url, :alt => user.name, :class => avatar_class)  
  end
  
end
