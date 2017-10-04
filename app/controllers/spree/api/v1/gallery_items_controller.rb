module Spree
  module Api
    module V1
      class GalleryItemsController < Spree::Api::BaseController
        before_action :find_product
        before_action :find_gallery

        def classify
          authorize! :create, GalleryItem
          @gallery_item = Spree::GalleryItem.new({ gallery: @gallery, product: @product })
          if @gallery_item.save
            respond_with(@gallery_item, status: 200, default_template: :show)
          else
            invalid_resource!(@gallery_item)
          end
        end

        def sort
          authorize! :update, GalleryItem
          gallery_item = Spree::GalleryItem.find_by(gallery: @gallery, product: @product)
          # Because position we get back is 0-indexed.
          # acts_as_list is 1-indexed.
          gallery_item.insert_at(params[:position].to_i + 1)
          head :ok
        end

        def remove
          gallery_item = Spree::GalleryItem.find_by(gallery_id: params[:gallery_id], product_id: params[:product_id])
          gallery_item.destroy if gallery_item.present?
          head :no_content
        end

        private

        def find_product
          @product = super(params[:product_id])
          authorize! :read, @product
        end

        def find_gallery
          @gallery ||= Spree::Gallery.accessible_by(current_ability, :read).find(params[:gallery_id])
        end
      end
    end
  end
end