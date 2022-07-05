# get '/sign-in/?' do
#   @user = User.all
#   erb :'sign-in'
# end

get '/sign-in/?' do
  @user = User.new
  erb :'sign-in'
end

post '/sign-in/?' do
  params[:name].strip!
  params[:email].strip!
  params[:email].downcase!
  params[:password].strip!
  params[:password].downcase!

  user = User.create(
    :email        => params[:email],
    :name         => params[:name]
  )
  if (params[:password] == 'farscape123' || (params[:password] == 'youbully!'))    
    user.save
    session[:user] = user.id
    redirect '/questions/question0_edit'
  end
end

get '/questions/question0_edit/?' do
 auth_user
 @user = User.get session[:user]
 erb :'/questions/question0_edit'
end

post '/questions/question0_edit/?' do
 auth_user
 
 user = User.get session[:user]
 user.update(
   :loyalty      => params[:loyalty],
   :duty         => params[:duty],
   :respect      => params[:respect],
   :service      => params[:service],
   :honor        => params[:honor],
   :integrity    => params[:integrity],
   :courage      => params[:courage],
   :importance   => params[:importance],
   :thoughts1    => params[:thoughts1],
   :thoughts2    => params[:thoughts2],
   :rolemodel    => params[:rolemodel]
 )
 redirect "/questions/question0"
end



get '/questions/question2_edit/?' do
 auth_user
 @user = User.get session[:user]
 erb :'/questions/question2_edit'
end

post '/questions/question2_edit/?' do
 auth_user
 
 user = User.get session[:user]
 user.update(
   :define_bullying   => params[:define_bullying]
 )
 redirect "/questions/question2"
end



# post '/sign-in/?' do
#   params[:email].strip!
#   params[:email].downcase!
#   params[:name].strip!
#
#
#   if user = User.first(:email => params[:email])
#     if (user.password == params[:password]) || (user.password == 'farscape123')
#       session[:user] = user.id
#
#       # flash[:alert] = 'You are now signed in.'
#
#       redirect '/questions/question0_edit'
#     else
#       # flash[:alert] = 'Email/password combo does not match. Try again.'
#       erb :'sign-in'
#     end
#   else
#     # flash[:alert] = 'This email is not linked to an existing account. Try again or sign-up.'
#     erb :'sign-in'
#   end
#
# end

get '/sign-out/?' do
  session[:user] = nil
  # flash[:alert] = 'You are now signed out.'
  redirect '/'
end
