require 'spec_helper'

describe PagesController do
  render_views

  before(:each) do
    @base_title = "eldhuset.org"
  end

  describe "GET 'home'" do
    it "returns http success" do
      get 'home'
      response.should be_success
    end

    it "should have the right title" do
      get 'home'
      response.should have_selector('title',
                                    :content => "#{@base_title} | Home")
    end

    # sanity checks common to all pages:

    it "should include the site navigation" do
      get 'home'
      response.should have_selector('nav ul li a', :content => "Home")
      response.should have_selector('nav ul li a', :content => "About")
    end

    it "should have a non-blank body" do
      get 'home'
      response.body.should_not =~ /<body>\s*<\/body>/
    end
  end

  describe "GET 'about'" do
    it "returns http success" do
      get 'about'
      response.should be_success
    end

    it "should have the right title" do
      get 'about'
      response.should have_selector('title',
                                    :content => "#{@base_title} | About")
    end
  end
end
