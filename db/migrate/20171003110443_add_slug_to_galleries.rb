class AddSlugToGalleries < ActiveRecord::Migration
  def up
    add_column :spree_galleries, :slug, :string

    Spree::Gallery.where('slug is null').each do |gallery|
      gallery.slug = nil # Regenerate the slug
      gallery.save!
    end

    change_column_null :spree_galleries, :slug, false
    add_index :spree_galleries, :slug, unique: true
  end

  def down
    remove_column :spree_galleries, :slug, :string
  end
end