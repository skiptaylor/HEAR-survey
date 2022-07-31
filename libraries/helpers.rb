helpers do
  
	def sign_in recruiter_id, msg = false
		recruiter = Recruiter.get recruiter_id
		session[:recruiter] = recruiter.id
		session[:admin] = recruiter.admin?
		if msg
			session[:alert] = {
				style: 'alert-success',
				heading: 'Thank You!',
				message: 'Payment Accepted.'
			}
		end
		redirect '/recruiter/recprofile'
	end
  
  
  def auth_recruiter
    unless session[:recruiter] || session[:admin]
      flash[:alert] = 'You do not have permission to see that page.'
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
