# frozen_string_literal: true

module Api
  class CategoriesController < ApplicationController
    def index
      @categories = Category.order(:id)
    end
  end
end
