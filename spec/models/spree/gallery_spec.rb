require 'spec_helper'

RSpec.describe Spree::Gallery, type: :model do
  context 'validation' do
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:title) }
  end

  context "#create" do
    it "should contain products" do
      expect(create(:gallery_with_products, products_count: 5).products.length).to eq(5)
    end
  end

  context 'search' do
    it 'correctly finds gallery by store' do
      @store = create(:store)
      @gallery = create(:gallery, store: @store)
      @gallery2 = create(:gallery)
      gallery_by_store = Spree::Gallery.by_store(@store)

      gallery_by_store.should include(@gallery)
      gallery_by_store.should_not include(@gallery2)
    end
  end
end