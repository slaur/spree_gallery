FactoryGirl.define do

  # gallery factory without associated products
  factory :gallery, class: Spree::Gallery do
    sequence(:name) { |n| "Gallery_#{n}" }
    sequence(:title) { |n| "Title_#{n}" }

    # gallery_with_products will create product data after the gallery has been created
    factory :gallery_with_products do
      # products_count is declared as a transient attribute and available in
      # attributes on the factory, as well as the callback via the evaluator
      transient do
        products_count 5
      end

      # the after(:create) yields two values; the gallery instance itself and the
      # evaluator, which stores all values from the factory, including transient
      # attributes; `create_list`'s second argument is the number of records
      # to create and we make sure the gallery is associated properly to the product
      after(:create) do |gallery, evaluator|
        create_list(:product, evaluator.products_count, galleries: [gallery])
      end
    end
  end
end