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

    it "should have the right <title>" do
      get 'show', :id => @post
      response.should have_selector('title',
                                    :content => @post.title)
    end

    it "should have an h1 with the right title" do
      get 'show', :id => @post
      response.should have_selector('h1',
                                    :content => @post.title)
    end
    
    it "should include an img when an image is included" do
      get 'show', :id => @post
      response.should have_selector('img',
                                    :src => @post.image.thumb.url)
    end

    it "should link to the full-size image" do
      get 'show', :id => @post
      response.should have_selector('a',
                                    :href => @post.image.url)
    end
  end

  describe "POST '/posts'" do
    it "should not create a post without a title" do
      lambda do
        post 'create', :body => "Lorem ipsum yada yada"
      end.should_not change(Post, :count)
    end

    it "should not create a post without a body" do
      lambda do
        post 'create', :title => "Hello, world!"
      end.should_not change(Post, :count)
    end
  end
end
