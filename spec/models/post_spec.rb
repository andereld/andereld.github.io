require 'spec_helper'

describe Post do
  
  before(:each) do
    @post = FactoryGirl.create(:post)
  end

  it "should create a new post given valid input" do
    Post.create!(:title => @post.title, :body => @post.body)
  end

  it "should require a title" do
    p = Post.new(:body => @post.body)
    p.should_not be_valid
  end

  it "should require a body" do
    p = Post.new(:title => @post.title)
    p.should_not be_valid
  end

  it "should reject titles that are too long" do
    long_title = 'a' * 256
    p = Post.new(:title => long_title, :body => @post.body)
    p.should_not be_valid
  end

  it "should reject invalid / non-image files" do
    f = File.open("#{Rails.root}/spec/data/nonsense.png")
    p = Post.new(:title => @post.title, :body => @post.body, :image => f)
    p.should_not be_valid
  end
end
