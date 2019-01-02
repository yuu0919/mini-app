class BlogsController < ApplicationController

  before_action :move_to_index, except: [:index, :show]

  def index
    @blogs = Blog.includes(:user).order('created_at DESC').page(params[:page]).per(5)
  end

  def new
  end

  def create
    @blogs = Blog.create(title: blog_params[:title], image: blog_params[:image], text: blog_params[:text], user_id: current_user.id)
    redirect_to :blogs, action: :index
  end

  def show
    @blog = Blog.find(params[:id])
    @comments = @blog.comments.includes(:user)
  end

  def destroy
    blog = Blog.find(params[:id])
    blog.destroy if current_user.id == blog.user_id
    redirect_to :blogs, action: :index
  end

  def update
    blog = Blog.find(params[:id])
    if blog.user_id == current_user.id
      blog.update(blog_params)
    end
    redirect_to :blogs, action: :show
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  private

  def blog_params
    params.permit(:title, :image, :text).merge(user_id: current_user.id)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end
