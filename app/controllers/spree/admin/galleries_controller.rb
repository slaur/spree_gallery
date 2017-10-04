module Spree
  module Admin
    class GalleriesController < ResourceController
      def find_resource
        Spree::Gallery.friendly.find(params[:id])
      end
    end
  end
end