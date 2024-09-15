# frozen_string_literal: true

module Web
  class Movies::ReviewsController < Web::Movies::ApplicationController
    def index
      @reviews = resource_movie.reviews
    end

    def new
      @review = resource_movie.reviews.build
    end

    def create
      @review = resource_movie.reviews.build(review_params)

      if @review.save
        redirect_to movie_reviews_url(resource_movie), notice: 'Review was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @review = review
    end

    def update
      @review = review
      if @review.update(review_params)
        redirect_to movie_reviews_url(resource_movie), notice: 'Review was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @review = review
      @review.destroy
      redirect_to movie_reviews_url(resource_movie), notice: 'Review was successfully deleted.'
    end

    private

    def resource_movie
      @resource_movie ||= Movie.find(params[:movie_id])
    end

    def review
      resource_movie.reviews.find(params[:id])
    end

    def review_params
      params.require(:review).permit(:body, :movie_id)
    end
  end
end
