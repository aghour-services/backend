module Api
  class SearchController < ApplicationController
    def index
      @results = Firm.search params[:keyword]
    end
  end
end
