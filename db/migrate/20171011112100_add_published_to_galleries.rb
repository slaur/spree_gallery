class AddPublishedToGalleries < ActiveRecord::Migration
  def change
    add_column :spree_galleries, :published, :boolean, default: false
  end
end
