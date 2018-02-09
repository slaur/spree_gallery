class AddStoreRefToGallery < ActiveRecord::Migration
  def up
    if table_exists?('spree_galleries')
      add_column :spree_galleries, :store_id, :integer
      add_index :spree_galleries, :store_id
    end
  end

  def down
    if table_exists?('spree_galleries')
      remove_column :spree_galleries, :store_id
    end
  end
end
