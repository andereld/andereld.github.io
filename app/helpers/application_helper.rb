module ApplicationHelper
  
  def page_title
    # returns content for title element
    @title.nil? ? "eldhuset.org" : "eldhuset.org | #{@title}"
  end
end
