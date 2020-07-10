module Admin

  class FeedbacksController < ::ApplicationController

    def index
      authorize Feedback
      @feedbacks = FeedbackSeeker.search(query: params[:q], page: params[:page])
    end

  end

end