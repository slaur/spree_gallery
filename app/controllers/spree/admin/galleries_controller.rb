module Spree
  module Admin
    class GalleriesController < ResourceController
      def find_resource
        Spree::Gallery.friendly.find(params[:id])
      end

      def upload_items
        @gallery = Spree::Gallery.friendly.find(params[:id])
        begin
          file = params[:upload_file]
          products_not_found = 0
          products_existing = 0
          products_added = 0
          CSV.foreach(file.path, headers: false) do |row|
            product = Spree::Product.find_by(name: row[0])
            if product.blank?
              products_not_found += 1
              next
            end
            if @gallery.products.include?(product)
              products_existing += 1
            else
              @gallery.products << product
              products_added += 1
            end
          end
          flash[:notice] = t('spree_gallery.upload_results', {added: products_added, existing: products_existing, not_found: products_not_found})
        rescue
          flash[:error] = t('spree_gallery.upload_error')
        ensure
          redirect_to edit_admin_gallery_path(@gallery)
        end
      end
    end
  end
end