# frozen_string_literal: true

module Web
  class Movies::CommentsController < Web::Movies::ApplicationController
    def index
      @comments = resource_movie.comments
    end

    def new
      @comment = resource_movie.comments.build
    end

    def create
      @comment = resource_movie.comments.build(comment_params)

      if @comment.save
        redirect_to movie_comments_url(resource_movie), notice: 'Comment was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @comment = comment
    end

    def update
      @comment = comment
      if @comment.update(comment_params)
        redirect_to movie_comments_url(resource_movie), notice: 'Comment was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @comment = comment
      @comment.destroy
      redirect_to movie_comments_url(resource_movie), notice: 'Comment was successfully deleted.'
    end

    private

    def comment
      resource_movie.comments.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:body)
    end
  end
end
