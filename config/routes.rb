Jets.application.routes.draw do
  post 'meals/next/kor', to: "meals#show_next_kor"
  post 'meals/next/eng', to: "meals#show_next_eng"
  post 'meals/specific', to: "meals#show_specific"
  resources :meals
  get 'buildings/oneone'
  post 'buildings/oneone'
  get 'buildings/onetwo'
  post 'buildings/onetwo'
  get 'buildings/twoone'
  
  root "jets/public#show"
  # The jets/public#show controller can serve static utf8 content out of the public folder.
  # Note, as part of the deploy process Jets uploads files in the public folder to s3 
  # and serves them out of s3 directly.S3 is well suited to serve static assets. 
  # More info here: https://rubyonjets.com/docs/extras/assets-serving/ 
  any "*catchall", to: "jets/public#show" 
end