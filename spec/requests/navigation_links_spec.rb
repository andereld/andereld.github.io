require 'spec_helper'

describe "navigation links and paths" do

  it "should have a home page at '/'" do
    get '/'
    response.should have_selector('title', :content => 'Home')
  end

  it "should have an about page at '/about'" do
    get '/about'
    response.should have_selector('title', :content => 'About')
  end

  it "should have the right navigation links" do
    visit root_path
    click_link 'Home'
    response.should have_selector('title', :content => 'Home')
  end
end
