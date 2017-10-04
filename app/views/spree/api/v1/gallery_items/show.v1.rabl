object @gallery_item

node(:id, &:id)

child product: :product do
  extends 'spree/api/v1/products/show'
end