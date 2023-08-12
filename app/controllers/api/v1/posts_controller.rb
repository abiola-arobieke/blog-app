class Api::V1::PostsController < ApplicationController
  def index
    post = User.find(params['user_id']).posts

    render json: post
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user
    @post.comments_counter = 0
    @post.likes_counter = 0
    if @post.save
      render json: @post, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
