# frozen_string_literal: true

module Api
  class CategoriesController < ApplicationController
    CACHE_KEY = 'categories#index'
    before_action :fetch_category, only: %I[tags]

    after_action :cache_response, except: %I[tags]
    before_action :check_cached, except: %I[tags]

    def index
      if @cached_response
        render json: @cached_response
        return
      end
      @categories = Category.order(:id)
    end

    def tags
      @tags = @category.firms.where.not(tags: nil).pluck(:tags).map { |list| list.split('-') }.flatten.uniq.sort
    end

    private

    def fetch_category
      @category = Category.find params[:category_id]
    end

    def check_cached
      @cached_response = REDIS_CLIENT.get CACHE_KEY
    end

    def cache_response
      REDIS_CLIENT.setex CACHE_KEY, 3.hours, response.body
    end
  end
end
