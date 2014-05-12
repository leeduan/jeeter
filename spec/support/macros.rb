def set_admin_user
  session[:user_id] = Fabricate(:admin).id
end

def clear_current_user
  session[:user_id] = nil
end