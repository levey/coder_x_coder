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

  def process_mentions(text)
    text.gsub(Comment::MENTION_REGEXP) do
      if $1.present? && !User.find_by_username($1).nil?
        %(<a href="/users/#{User.find_by_username($1).id}">@#{$1}</a>)
      else
        "@#{$1}"
      end
    end
  end

  def generate_markdown(text)
    markdown = RDiscount.new(process_mentions(text), :smart).to_html.html_safe
  end
end
