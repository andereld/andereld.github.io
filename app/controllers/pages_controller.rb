class PagesController < ApplicationController

  def home
    @title = "Home"
    render 'posts/index', :layout => 'home'
  end

  def about
    @title = "About"
  end
end
