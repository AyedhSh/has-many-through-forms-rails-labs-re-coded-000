class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
   @comment=@post.comments.build
   @comment.user=User.new
   @users = User.joins(:comments).includes(:comments).where(:comments => {post_id: @post.id}).distinct
  end

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
    @post.categories.build


  end

  def create

    post = Post.create(post_params)
    redirect_to post
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, category_ids:[], categories_attributes: [:name])
  end
end