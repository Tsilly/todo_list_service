Rails.application.routes.draw do
  
  devise_for :users
  post "/graphql", to: "graphql#execute"
  
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/3001"
  end
end
