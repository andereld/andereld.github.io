class PostsController < ApplicationController

  http_basic_authenticate_with :name => APP_CONFIG['username'],
                               :password => APP_CONFIG['password'],
                               :except => [:index, :show]

  def index
    @title = "Home"
  end

  def show
    @post = Post.find(params[:id])
    @title = @post.trunc_title
  rescue ActiveRecord::RecordNotFound
    redirect_to :action => 'index'
  end

  def new
    @title = "New post"
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(params[:post])
    if @post.save
      flash[:success] = "Created post ‘#{@post.title}’."
      @title = @post.trunc_title
      render 'show'
    else
      redirect_to @post, :flash => "Couldn't save post."
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.update_attributes!(params[:post])
    redirect_to @post
  end

  def destroy
    Post.find(params[:id]).destroy
    flash[:success] = "Post destroyed."
    redirect_to posts_path
  end
end
