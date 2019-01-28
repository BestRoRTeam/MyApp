module Api
  class SearchController < ApplicationController
    def index
      provider = SearchProvider.new(params[:key])

      render json: provider.results
    end
  end
end
