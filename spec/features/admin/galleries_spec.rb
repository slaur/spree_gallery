require 'spec_helper'

feature 'Galleries' do
  stub_authorization!

  let(:gallery) {create(:gallery, name: 'Foo')}

  scenario 'admin should be able to edit gallery' do
    visit spree.edit_admin_gallery_path(gallery)

    fill_in 'gallery_name', with: 'Bar'
    fill_in 'gallery_title', with: 'Baz'

    click_button 'Update'
    expect(page).to have_content('Gallery "Bar" has been successfully updated!')
  end

  scenario 'gallery without name should not be updated' do
    visit spree.edit_admin_gallery_path(gallery)

    fill_in 'gallery_name', with: ''
    fill_in 'gallery_title', with: 'Baz'

    click_button 'Update'
    expect(page).to have_content("Name can't be blank")
  end

  scenario 'admin should be able to remove a product from a gallery', js: true do
    gallery_with_product = create(:gallery_with_products, products_count: 1)
    expect(gallery_with_product.products.length).to eq(1)
    visit spree.edit_admin_gallery_path(gallery_with_product)
    wait_for_ajax
    find('.product').hover
    find('.product .js-delete-product').click
    wait_for_ajax
    gallery_with_product.reload
    expect(gallery_with_product.products).to be_empty
  end
end