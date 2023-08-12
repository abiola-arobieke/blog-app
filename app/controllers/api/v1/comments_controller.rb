class Api::V1::CommentsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, only: [:create], if: -> { request.format.json? }

  def index
    comments = load_comments
    render json: comments
  end

  def create
    post = Post.find(params[:post_id])
    comment = post.comments.new(comment_params)
    comment.author = current_user

    if comment.save
      render json: comment, status: :created
    else
      render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def load_comments
    user = User.find(params[:user_id])
    post = user.posts.find(params[:post_id])
    post.comments
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
