module ApplicationHelper
  include Devise::DeviseHelper
  def title(page_title)
    content_for(:title) { page_title }
  end
end
