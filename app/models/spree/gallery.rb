class Spree::Gallery < ActiveRecord::Base
  extend FriendlyId

  has_many :gallery_items, -> { order(:position) }, class_name: 'GalleryItem', dependent: :delete_all, inverse_of: :gallery
  has_many :products, through: :gallery_items
  belongs_to :store

  friendly_id :title, use: :slugged

  validates :name, presence: true
  validates :title, presence: true

  scope :published, -> { where(published: true) }
  scope :by_store, ->(store) { where(store_id: store) }
end