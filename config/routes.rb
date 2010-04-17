# Put your extension routes here.

# map.namespace :admin do |admin|
#   admin.resources :whatever
# end  
map.robo_kassa_check_result '/robokassa/check_result', :controller => :robo_kassa, :action => :result
map.robo_kassa_success '/robokassa/success', :controller => :robo_kassa, :action => :success
map.robo_kassa_fail '/robokassa/fail', :controller => :robo_kassa, :action => :fail
