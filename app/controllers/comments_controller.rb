class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.author = current_user

    if @comment.save
      redirect_to user_post_path(current_user.id, @post.id), notice: 'Comment added.'
    else
      render 'posts/show'
    end
  end

  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
