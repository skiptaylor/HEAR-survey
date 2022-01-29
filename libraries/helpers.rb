helpers do
  
  def auth_user
    unless session[:user] || session[:admin]
      # flash[:alert] = 'You do not have permission to see that page.'
      redirect '/'
    end
  end
  
  def auth_admin
    unless session[:admin]
      redirect '/'
    end
  end
  
  def active path
		path = Array[path] unless path.kind_of? Array
		match = false
		path.each {|p| match = true if request.path_info.include? p}
		'active' if match
  end
  
end
