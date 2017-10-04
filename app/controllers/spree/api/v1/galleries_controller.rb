module Spree
  module Api
    module V1
      class GalleriesController < Spree::Api::BaseController
        def products
          # Returns the products sorted by their position in gallery
          gallery = Spree::Gallery.find(params[:id])
          @products = gallery.products.ransack(params[:q]).result
          @products = @products.page(params[:page]).per(params[:per_page] || 50)
          render 'spree/api/v1/products/index'
        end
      end
    end
  end
end