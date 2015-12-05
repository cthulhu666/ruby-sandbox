Rails.application.routes.draw do

  scope 'api', defaults: {format: 'json'} do
    resources :snippets do
      post '_freeze', on: :member, to: 'snippets#freeze'
      post '_fork', on: :member, to: 'snippets#fork'
      resources :executions
    end
  end
end
