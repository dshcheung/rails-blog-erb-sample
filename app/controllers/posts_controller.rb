class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:show, :update, :edit, :destroy]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to post_path(@post)
    else
      flash[:notice] = @post.errors.messages
      redirect_to :new
    end
  end

  def update
    @post.assign_attributes(post_params)

    if @post.save
      redirect_to post_path(@post)
    else
      flash[:notice] = @post.errors.messages
      redirect_to :edit
    end
  end

  def destroy
    @post.destroy

    redirect_to :index
  end

private

  def set_post
    @post = Post.find_by_id(params[:id])
    if @post.nil?
      flash[:notice] = "Cannot find post with ID #{params[:id]}"
      redirect_to :index
    end
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
