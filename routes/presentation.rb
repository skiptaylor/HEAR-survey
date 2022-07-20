get '/recruiter/school/:id/presentation/new/?' do
  auth_recruiter
  @recruiter = Recruiter.get(session[:recruiter])
  @school = School.get(params[:id])
  @presentation = Presentation.new
  erb :'/recruiter/presentation_edit'
end

post '/recruiter/school/:id/presentation/new/?' do
  auth_recruiter
  recruiter = Recruiter.get(session[:recruiter])
  school = School.get(params[:id])
  presentation = Presentation.create(
    :recruiter_id         => session[:recruiter],
    :school_password      => params[:school_password],
    :class_date           => params[:class_date]
  )
  redirect "/recruiters/profile"
end

get '/recruiters/:id/school/presentation/?' do
  auth_recruiter
  @recruiter = Recruiter.get(session[:recruiter])
  @school = School.get(params[:school_id])
  @presentation = Presentation.get(params[:id])
  erb :'/student/resume/objectives/objectives'
end

get '/recruiters/school/presentations/:id/edit/?' do
  auth_recruiter
  @recruiter = Recruiter.get(session[:recruiter])
  @school = School.get(params[:school_id])
  @presentation = Presentation.get(params[:id])
  erb :'/recruiters/presentation_edit'
end

post '/recruiters/school/presentations/:id/edit/?' do
  auth_recruiter
  recruiter = Recruiter.get(session[:recruiter])
  school = School.get(params[:school_id])
  presentation.update(
  :recruiter_id         => session[:recruiter],
  :school_password      => params[:school_password],
  :class_date           => params[:class_date]
  )
  redirect "/student/resume/index"
end

get '/recruiters/school/presentations/:id/delete/?' do
  auth_recruiter
  recruiter = Recruiter.get(session[:recruiter])
  @school = School.get(params[:school_id])
  presentation = Presentation.get(params[:id])
  presentation.destroy
  redirect '/student/resume/objectives/objectives'
end

