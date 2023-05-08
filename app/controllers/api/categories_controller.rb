# frozen_string_literal: true

module Api
  class CategoriesController < ApplicationController
    CACHE_KEY = 'categories#index'

    # after_action :cache_response
    # before_action :check_cached

    def index
      if @cached_response
        render json: @cached_response
        return
      end
      @categories = Category.order(:id)
    end

    private

    def check_cached
      @cached_response = REDIS_CLIENT.get CACHE_KEY
    end

    def cache_response
      REDIS_CLIENT.setex CACHE_KEY, 3.hours, response.body
    end
  end
end
