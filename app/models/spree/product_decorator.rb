Spree::Product.class_eval do
  has_many :gallery_items, class_name: 'GalleryItem', dependent: :delete_all, inverse_of: :product
  has_many :galleries, through: :gallery_items
end