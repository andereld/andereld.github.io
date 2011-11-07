require 'spec_helper'

describe PostsController do
  render_views

  describe "GET '/posts'" do
    it "returns HTTP success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET '/posts/:id'" do
    before(:each) do
      @post = Factory(:post)
    end

    it "returns HTTP success" do
      get 'show', :id => @post
      response.should be_success
    end

    it "should have the right title" do
      get 'show', :id => @post
      response.should have_selector('title',
                                    :content => @post.title
                                      .truncate(12, :seperator => ' '))
    end

    it "should have an h2 with the right title" do
      get 'show', :id => @post
      response.should have_selector('h2',
                                    :content => @post.title)
    end
  end
end
