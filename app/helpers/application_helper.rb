module ApplicationHelper
  
  def generate_title(page_title)
    base_title = "coderXcoder"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
end
