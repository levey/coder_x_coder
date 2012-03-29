module ApplicationHelper
  require 'rdiscount'

  def generate_title(page_title)
    base_title = "C x C"
    if page_title.empty?
      base_title
    else
      "#{page_title} - #{base_title}"
    end
  end

  def generate_markdown(text)
    markdown = RDiscount.new(text, :smart).to_html.html_safe
  end
end
