get '/?' do
  @user = User.get session[:user]
  erb :'/home'
end

get '/home/?' do
  @user = User.get session[:user]
	erb :'/home'
end

get '/questions/question0/?' do
  auth_user
  @user = User.get session[:user]
	erb :'/questions/question0'
end

get '/questions/question2/?' do
  auth_user
  @user = User.get session[:user]
	erb :'/questions/question2'
end

get '/questions/question3/?' do
  auth_user
  @user = User.get session[:user]
	erb :'/questions/question3'
end

get '/questions/question4/?' do
  auth_user
  @user = User.get session[:user]
	erb :'/questions/question4'
end

get '/questions/question5/?' do
  auth_user
  @user = User.get session[:user]
	erb :'/questions/question5'
end

get '/questions/question6/?' do
  auth_user
  @user = User.get session[:user]
	erb :'/questions/question6'
end

get '/questions/question7/?' do
  auth_user
  @user = User.get session[:user]
	erb :'/questions/question7'
end

get '/questions/question8/?' do
  auth_user
  @user = User.get session[:user]
	erb :'/questions/question8'
end

get '/questions/question9/?' do
  auth_user
  @user = User.get session[:user]
	erb :'/questions/question9'
end

get '/questions/question10/?' do
  auth_user
  @user = User.get session[:user]
	erb :'/questions/question10'
end

get '/questions/question11/?' do
  auth_user
  @user = User.get session[:user]
	erb :'/questions/question11'
end
