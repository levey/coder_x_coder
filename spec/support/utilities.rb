def generate_title(page_title)
  base_title = "Coder x Coder"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end

def sign_in(user)
  visit signin_path
  fill_in "Name or email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
  # # Sign in when not using Capybara as well.
  # cookies[:remember_token] = user.remember_token
end