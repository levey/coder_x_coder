def generate_title(page_title)
  base_title = "C x C"
  if page_title.empty?
    base_title
  else
    "#{page_title} - #{base_title}"
  end
end

def sign_in(user)
  page.driver.post new_user_session_path, login: user.username, password:'whatever'
end