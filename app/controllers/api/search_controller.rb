# frozen_string_literal: true

module Api
  class SearchController < ApplicationController
    def index
      @results = Firm.published.includes(:category).search params[:keyword]
    end
  end
end
