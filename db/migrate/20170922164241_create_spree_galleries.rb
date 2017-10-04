class CreateSpreeGalleries < ActiveRecord::Migration
  def change
    create_table :spree_galleries do |t|
      t.string :name
      t.string :title
      t.string :description
      t.timestamps
    end

    create_table :spree_gallery_items do |t|
      t.belongs_to :gallery, index: true
      t.belongs_to :product, index: true
      t.integer :position
    end
  end
end