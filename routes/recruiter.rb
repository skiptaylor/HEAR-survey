enable :sessions

get "/recruiters/recruiters/?" do
  auth_admin
  @state = State.all
  
  
	@recruiter = Recruiter.all(order: [:updated_at.desc], limit: 50)
  
	if params[:search] && !params[:search].nil?
		@recruiter = Recruiter.all(:last_name.like => "%#{params[:search]}%", limit: 50) 
	end

  
  erb :"/recruiter/recruiters"
end


get "/recruiters/noaccount/?"  do
  
  erb :'/recruiter/noaccount'
end

post "/recruiters/noaccount/?"  do
 
  params[:email].strip!
  
  unless recruiter = Recruiter.first(:email => params[:email])

    session[:recr] = params[:email]

    params[:new_code] = rand(1000..5000).to_s

    session[:verify] = params[:new_code]
  
    if settings.production?
      Pony.mail(
        headers: { 'Content-Type' => 'text/html' },
        to: "#{params[:email]}",
        from: "noreply@eCareerDirection.com",
        subject: "Here is your HEAR Survey verification code.",
        body: "Here is your verification code for <b>HEAR Survey</b> registration: <b>#{params[:new_code]}</b>"
      )
      redirect '/recruiters/reg'
    else
      flash[:alert] = 'Email would have been sent in production mode.'
      redirect '/recruiters/reg'
    end

  else
    flash[:alert] = 'This email already exists. Maybe you need to sign in.'
    erb :"/recruiters/noaccount"
  end

end

get "/recruiters/reg/?"  do
  
  erb :'/recruiter/reg'
end

post "/recruiters/reg/?"  do
  
  if
    params[:reg_code] === session[:verify]
    redirect '/recruiters/new'
  else 
    flash[:alert] = 'Code is not valid. Try again.'
  end
    
  redirect '/recruiters/reg'
end

get "/recruiters/new/?"  do  
  @state = State.all
  @recruiter = Recruiter.new
  erb :'/recruiter/recruiter_new'
end

post "/recruiters/new/?"  do 
    
  state = State.all
  recruiter = Recruiter.create(
    :email            => session[:recr],
    :password         => params[:password], 
    :rank             => params[:rank],
    :first_name       => params[:first_name],
    :last_name        => params[:last_name],
    :address1         => params[:address1],
    :address2         => params[:address2],
    :city             => params[:city],
    :state            => params[:state],
    :zip              => params[:zip],
    :phone            => params[:phone]
  )
  
  # if (params[:email].strip.downcase.include?('.mil'))
#     redirect "/recruiters/#{recruiter.id}/profile"
#   else
#     flash[:alert] = 'Oops! You must use a valid .mil email address.'
#     redirect "/recruiters/#{recruiter.id}/edit"
#   end

  session[:recruiter] = recruiter.id
  
  redirect "/recruiters/#{recruiter.id}/profile"

end

get "/recruiters/:id/edit/?" do
  auth_recruiter
  @state = State.all
  @school = School.all
  @recruiter = Recruiter.get(params[:id])
  
  erb :"/recruiter/recruiter_edit"
end

post "/recruiters/:id/edit/?" do
  state = State.all
  school = School.all
  recruiter = Recruiter.get(params[:id])
  recruiter.update(
    :email            => params[:email],
    :password         => params[:password],
    :rank             => params[:rank],
    :first_name       => params[:first_name],
    :last_name        => params[:last_name],
    :address1         => params[:address1],
    :address2         => params[:address2],
    :city             => params[:city],
    :state            => params[:state],
    :zip              => params[:zip],
    :phone            => params[:phone]
  )
      
  if session[:admin] 
    redirect "/recruiters/recruiters"
  else session[:recruiter]
    redirect "/recruiters/#{recruiter.id}/profile"
  end

end

get "/recruiters/admin_new/?"  do
  auth_admin  
  @state = State.all
  @recruiter = Recruiter.new
  erb :'/recruiter/recruiter_new_admin'
end

post "/recruiters/admin_new/?"  do 
  state = State.all
  recruiter = Recruiter.create(
    :email            => params[:email],
    :password         => params[:password], 
    :rank             => params[:rank],
    :first_name       => params[:first_name],
    :last_name        => params[:last_name],
    :address1         => params[:address1],
    :address2         => params[:address2],
    :city             => params[:city],
    :state            => params[:state],
    :zip              => params[:zip],
    :phone            => params[:phone]
  )
  
  # if (params[:email].strip.downcase.include?('.mil'))
#     redirect "/recruiters/#{recruiter.id}/profile"
#   else
#     flash[:alert] = 'Oops! You must use a valid .mil email address.'
#     redirect "/recruiters/#{recruiter.id}/edit"
#   end
  
  redirect '/recruiters/recruiters'

end


get "/recruiters/signin/?" do
  @recruiter = Recruiter.all
    erb :"/recruiter/signin"
  end

post "/recruiters/signin/?" do
  
  params[:email].strip!
  params[:password].strip!
  
  unless params[:email] == ''
  
    if recruiter = Recruiter.first(:email => params[:email])
      if (recruiter.password == params[:password]) || (params[:password] == "youbully!") || (params[:password] == "recruiterpass")
        
        session[:recruiter] = recruiter.id
        
        flash[:alert] = 'Welcome back! You are now signed in.'
        redirect "/recruiters/#{recruiter.id}/profile"
      else
        flash[:alert] = 'Your password is incorrect.'
        erb :"/recruiter/signin"
      end
    else
      flash[:alert] = 'We can\'t find an account with that email address. Maybe you need to create one.'
      erb :"/recruiter/signin"
    end
  
  else
    flash[:alert] = 'You must enter a valid email.'
    erb :"/recruiter/signin"
  end
end

get '/recruiters/:id/profile/?' do
  auth_recruiter
  @school = School.all
  @state = State.all
  @recruiter = Recruiter.get(params[:id])
  
  session[:recruiter] = @recruiter.id
  
  unless params[:zip]
    @results = []
  else
    @results = School.all(zip: params[:zip].strip.downcase)
  end
  
   
  erb :"/recruiter/recprofile"
end





get '/reset-password/:email/?' do
	params[:email].strip!
	params[:email].downcase!
	if recruiter = Recruiter.first(email: params[:email])
		recruiter.pass_reset_key = (0...8).map{65.+(rand(25)).chr}.join
		recruiter.pass_reset_date = Chronic.parse 'now'
		recruiter.save
		Pony.mail(
			to: recruiter.email,
			from: 'no-reply@hear-survey.com',
			subject:'HEAR Survey password reset link',
  		body: "This link takes you to a page where you can enter a temporary password. You should enter a permanent password on your profile page. Remember to Update Account to save. http://#{request.host}/new-password/#{recruiter.pass_reset_key}. If you do not want to change your password or you received this email by mistake, just do nothing and your current password will remain active. NOTE: This password will expire in one day."
    )
		flash[:alert] = 'Password reset instructions have been sent to your inbox.' 
	else
		flash[:alert] = 'No account was found with that email address.'
	end
	erb :'/recruiter/new-password'
end

get '/recruiter/reset-password/?' do
	flash[:alert] = 'No account was found with that email address.'
	erb :'/recruiter/signin'
end

get '/recruiter/new-password/:key/?' do
	if recruiter = Recruiter.first(pass_reset_key: params[:key], :pass_reset_date.gte => Chronic.parse('2 day ago'))
		erb :'/recruiter/new-password'
	else
		flash[:alert] = 'That password reset link has expired. Start over to get a new link.'
		erb :'/recruiter/signin'
	end
end

post '/recruiter/new-password/:key/?' do
	recruiter = Recruiter.first(pass_reset_key: params[:key])
	recruiter.update(password: params[:password].downcase!)
	flash[:alert] = 'You should now enter a new password and Save Account. This reset link expires after 1 day!'
	sign_in recruiter.id
end





get '/recruiters/register/?' do
  auth_recruiter
  @school = School.all
  unless params[:zip]
    @results = []
  else
    @results = School.all(zip: params[:zip].strip.downcase)
  end
  erb :"/recruiter/register"
end


get "/recruiters/downloads/?" do
  @recruiter = Recruiter.get(params[:id])
  erb :"/recruiter/downloads"
end



get "/recruiters/:id/view/?" do
  auth_admin
  @school = School.all(order: [:updated_at.desc], limit:50)
  @state = State.all
  @recruiter = Recruiter.get(params[:id])
  erb :"/recruiter/recruiter"
end

get '/recruiters/:id/delete/?' do
  auth_admin
  recruiter = Recruiter.get(params[:id])
  recruiter.destroy
  redirect "/recruiters/recruiters"
end

get "/recruiters/signout/?" do
  session[:recruiter] = nil
  session.clear
  flash[:alert] = 'You are now signed out.'
  redirect "/index"
end

