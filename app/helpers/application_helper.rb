module ApplicationHelper
  
  def generate_title(page_title)
    base_title = "C x C"
    if page_title.empty?
      base_title
    else
      "#{page_title} - #{base_title}"
    end
  end
end
