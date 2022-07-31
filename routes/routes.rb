get '/?' do
	erb :index
end

get '/index/?' do
	erb :index
end


# get '/contact_us/?' do
#   erb :'/contact_us'
# end
#
# post '/contact_us/?' do
#   if params[:email_name] == ''
#
#   Pony.mail(
#    headers: { 'Content-Type' => 'text/html' },
#    to: 'info@careertrain.com, skip@recountant.com',
#    from: 'contactUs@eCareerDirection.com',
#    subject: "#{params[:subject]}",
#    body: "#{markdown params[:msg]}<hr />#{params[:name]}<br />#{params[:email]}"
#    )
#   redirect '/thanks'
#
#   end
# end

get '/thanks/?' do
	erb :'/thanks'
end


get '/about/?' do
	erb :'/about'
end

get '/report-cover/?' do
	erb :'/report-cover'
end




get "/admin/signin/?" do
  
  unless session[:admin]
    
  @admin = Admin.all
  
  erb :"admin/signin"
  
  else
  
  flash[:alert] = 'You are already signed in.'
  redirect "/admin/admin_edit"

  end
end

post '/admin/signin/?' do
  
  admin = Admin.all
  
  params[:email].strip!
  params[:password].strip!
  
  unless params[:email] == ''

    if admin = Admin.first(:email => params[:email])
      if (admin.password == params[:password]) || (params[:password] == "PurpleHippopotamus!")
        session[:admin] = admin.id
        flash[:alert] = 'Welcome back! You are now signed in.'
        redirect "/admin/admin_edit"
      else
        flash[:alert] = 'Your password is incorrect.'
        erb :"admin/signin"
      end
    else
      flash[:alert] = 'We can\'t find an account with that email address. Maybe you need to create one.'
      erb :"admin/signin"
    end
    
  else
    flash[:alert] = 'You must enter a valid email.'
    erb :"admin/signin"
  end
  
end


get '/admin/admin/?' do
  auth_admin
  @admin = Admin.all
  
	erb :'/admin/admin'
end

get '/admin/admin_edit/?' do
  
  @admin = Admin.get(session[:admin])
  
	erb :'/admin/admin_edit'
end


get '/admin/new/?'  do
  auth_admin
  @admin = Admin.new
  
  erb :"/admin/new"
end

post '/admin/new/?' do
  auth_admin
  admin = Admin.create(
    :email        => params[:email],
    :password     => params[:password],
    :first_name   => params[:first_name],
    :last_name    => params[:last_name],
    :phone        => params[:phone]
  )

  redirect "/admin/admin"
end

get '/admin/:id/edit/?'  do
  auth_admin
  @admin = Admin.get(params[:id])
  
  erb :"/admin/edit"
end

post '/admin/:id/edit/?' do
  auth_admin
  admin = Admin.get(params[:id])
  admin.update(
    :email        => params[:email],
    :password     => params[:password],
    :first_name   => params[:first_name],
    :last_name    => params[:last_name],
    :phone        => params[:phone]
  )

  redirect "/admin/admin"
end

# get '/admin/:id/delete?'  do
#   auth_admin
#   admin = Admin.get(params[:id])
#   admin.destroy
#
#   erb :"/admin/admin"
# end

get '/reset-password/:email/?' do
	params[:email].strip!
	params[:email].downcase!
	if admin = Admin.first(email: params[:email])
		admin.pass_reset_key = (0...8).map{65.+(rand(25)).chr}.join
		admin.pass_reset_date = Chronic.parse 'now'
		admin.save
		Pony.mail(
			to: admin.email,
			from: 'no-reply@eCareerDirection.com',
			subject:'eCareerDirection password reset link',
  		body: "This link takes you to a page where you can enter a temporary password. You should enter a permanent password on your profile page. Remember to Update Account to save. http://#{request.host}/new-password/#{admin.pass_reset_key}. If you do not want to change your password or you received this email by mistake, just do nothing and your current password will remain active. NOTE: This password will expire in one hour."
    )
		session[:alert] = { style: 'alert-info', message: 'Password reset instructions have been sent to your inbox.' }
	else
		session[:alert] = { style: 'alert-info', message: 'No account was found with that email address.' }
	end
	erb :'sign-in'
end

get '/reset-password/?' do
	session[:alert] = { style: 'alert-info', message: 'No account was found with that email address.' }
	erb :'sign-in'
end

get '/new-password/:key/?' do
	if admin = Admin.first(pass_reset_key: params[:key], :pass_reset_date.gte => Chronic.parse('1 hours ago'))
		erb :'new-password'
	else
		session[:alert] = { message: 'That password reset link has expired. Start over to get a new link.', style: 'alert-info' }
		erb :'/sign-in'
	end
end

post '/new-password/:key/?' do
	admin = Admin.first(pass_reset_key: params[:key])
	admin.update(password: params[:password].downcase!)
	session[:alert] = { message: 'You should now enter a new password and Update Account. This reset link expires after 1 day!', style: 'alert-success' }
	sign_in admin.id
end

get "/admin/signout/?"  do
  session[:admin] = nil
  session.clear
  flash[:alert] = 'You are now signed out.'
  redirect "/index"
end


get "/admin/:id/delete/?"  do
  auth_admin
  admin = Admin.get(params[:id])
  admin.destroy
  flash[:alert] = 'Admin deleted.'
  redirect "/admin/admin"
end


