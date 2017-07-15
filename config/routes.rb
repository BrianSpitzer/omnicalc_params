Rails.application.routes.draw do
  
  get("/flexible/square/:number",      { :controller => "calculations", :action => "flex_square"})
  get("/flexible/square_root/:number", { :controller => "calculations", :action => "flex_square_root"})
  get("/flexible/payment/:basis_points/:number_of_years/:present_value", { :controller => "calculations", :action => "flex_payment"})
  get("/flexible/random/:first_value/:second_value", { :controller => "calculations", :action => "flex_random"})
  
  get("/square/new",                   { :controller => "calculations", :action => "form_square"})
  get("/square/results",               { :controller => "calculations", :action => "form_square_result"})
  
  get("/square_root/new",              { :controller => "calculations", :action => "form_square_root"})
  get("/square_root/results",          { :controller => "calculations", :action => "form_square_root_result"})
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount WebGit::Engine, at: "/rails/git"
end