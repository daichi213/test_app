Rails.application.routes.draw do
  root "home#top"
  get "/about" , to: "home#about"
  # アクションの動作順番に上から並べる。ここでは、users#newが上
  get "/users/signup_form" , to: "users#new" , as: "users_new"
  post "/users/signup" , to: "users#signup"
  get "/users/login_form" , to: "users#login_form" , as: "users_login_form"
  post "/users/login" , to: "users#login" , as: "users_login"
  get "/users/index" , to: "users#index"
  get '/users/:id/show' , to: "users#show" , as: "users_show"
  get '/users/:id/edit' , to: "users#edit" , as: "users_edit"
  post '/users/:id/regist' , to: "users#regist" , as: "users_regist"
  get "/users/:id/like" , to: "users#like" , as: "users_like"

  post "/logout" , to:"users#logout" , as: "logout"
  post "/posts/create" , to: "posts#create"
  get "/posts/new" , to: "posts#new"
  #投稿一覧は編集ベージよりも先に動作するので、上にもってこなければならない
  get '/posts/index' , to: "posts#index"
  get "/posts/:id/show" , to: "posts#show" , as: "posts_show"
  get "/posts/:id/edit" , to: "posts#edit" , as: "posts_edit"
  post "/posts/:id/update" , to: "posts#update" , as: "posts_update"

  #削除は最も下にくる筈
  delete "/posts/:id/destroy" , to: "posts#destroy" , as: "posts_destroy"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  #投稿に対して「いいね」の表示を行うため、urlにはpost_idと明示的に使用する
  post "/likes/:post_id/add" , to: "likes#add" , as: "likes_add"
  post "/likes/:post_id/destroy" , to: "likes#destroy" , as:"likes_destroy"
end
