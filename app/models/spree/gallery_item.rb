class Spree::GalleryItem < ActiveRecord::Base
  belongs_to :gallery, class_name: 'Spree::Gallery'
  belongs_to :product, class_name: 'Spree::Product'
  acts_as_list scope: :gallery

  validates :gallery, :product, presence: true
  validates_uniqueness_of :product_id, scope: [:gallery_id]
end