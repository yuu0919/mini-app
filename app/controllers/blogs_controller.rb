class BlogsController < ApplicationController

  def index
    @blogs = Blog.order('created_at DESC').limit(5)
  end

  def new
    @blogs = Blog.new
  end

  def create
    @blogs = Blog.create(blog_params)
    redirect_to :blogs, action: :index
  end

  def show
  end

  def destroy
  end

  def update
  end

  private

  def blog_params
    params.require(:text).permit(:text)
  end
end
