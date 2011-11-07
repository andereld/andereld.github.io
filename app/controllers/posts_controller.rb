class PostsController < ApplicationController
  def index
    @title = "Posts"
  end

  def show
    @post = Post.find(params[:id])
    @title = @post.title.truncate(12, :seperator => ' ')
  end
end
