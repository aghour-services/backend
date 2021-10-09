module Api
  class SearchController < ApplicationController
    def index
      @results = Firm.includes(:category).search params[:keyword]
    end
  end
end
