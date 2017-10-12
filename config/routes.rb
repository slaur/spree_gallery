Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :galleries do
      collection do
        post :upload_items
      end
    end
  end

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :gallery_items do
        collection do
          post :classify
          put :sort
          delete :remove
        end
      end

      get '/galleries/products', to: 'galleries#products', as: :gallery_products
    end
  end
end