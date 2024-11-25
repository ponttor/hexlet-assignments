# frozen_string_literal: true

class CommentsController < Posts::ApplicationController
  before_action :set_comment, only: %i[show edit update destroy]

  def index
    @comments = resource_post.comments
  end

  def show; end

  def new
    @comment = resource_post.comments.build
  end

  def create
    @comment = resource_post.comments.build(comment_params)
    if @comment.save
      redirect_to [resource_post, @comment], notice: 'Comment was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to [resource_post, @comment], notice: 'Comment was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    redirect_to post_comments_path(resource_post), notice: 'Comment was successfully deleted.'
  end

  private

  def set_comment
    @comment = resource_post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content, :author)
  end
end
