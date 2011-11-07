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
                                    :content => @post.trunc_title)
    end

    it "should have an h2 with the right title" do
      get 'show', :id => @post
      response.should have_selector('h2',
                                    :content => @post.title)
    end
  end

  describe "POST '/posts'" do
    it "should not create a post without a body" do
      lambda do
        post 'create', :title => "Hello, world!"
      end.should_not change(Post, :count)
    end

    it "should not create a post without a title" do
      lambda do
        post 'create', :body => "Lorem ipsum yada yada"
      end.should_not change(Post, :count)
    end
  end
end
