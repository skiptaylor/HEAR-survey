get '/schools/schools/?' do
  auth_recruiter
	@school = School.all(order: [:updated_at.desc], limit: 100)
  
	if params[:search] && !params[:search].nil?
		@school = School.all(:zip.like => "%#{params[:search]}%", limit: 30) 
  else
		@school = School.all(:school_name.not => nil, order: [:updated_at.desc], limit: 100)
	end
  
	erb :'/schools/schools'
end

get '/schools/create/?' do
  auth_recruiter
  @state = State.all
  @recruiter = Recruiter.all
  @school = School.new
  erb :'/schools/new_admin_school'
end

post '/schools/create/?' do
  auth_recruiter
  state = State.all
  recruiter = Recruiter.all
  school = School.create(
    :date_modified          => params[:date_modified],
    :first_name             => params[:first_name],
    :last_name              => params[:last_name],
    :email                  => params[:email],
    :phone                  => params[:phone],
    :school_name            => params[:school_name],
    :address1               => params[:address1],
    :address2               => params[:address2],
    :city                   => params[:city],
    :state                  => params[:state],
    :zip                    => params[:zip],
    :school_password        => params[:school_password],         
    :class_date             => params[:class_date]                         
  )                                                                          
                                                                             
  redirect "/schools/schools"                                    
end                                                                          


get '/schools/new/?' do
  auth_recruiter
  @state = State.all
  @recruiter = Recruiter.all
  @school = School.new
  erb :'/schools/edit_school'
end

post '/schools/new/?' do
  auth_recruiter
  state = State.all
  recruiter = Recruiter.all
  school = School.create(
    :school_id              => params[:school_id],
    :date_modified          => params[:date_modified],
    :first_name             => params[:first_name],
    :last_name              => params[:last_name],
    :email                  => params[:email],
    :phone                  => params[:phone],
    :school_name            => params[:school_name],
    :address1               => params[:address1],
    :address2               => params[:address2],
    :city                   => params[:city],
    :state                  => params[:state],
    :zip                    => params[:zip],
    :school_password        => params[:school_password],         
    :class_date             => params[:class_date],                                                           
    :recruiter_id           => params[:recruiter_id]                         
)                                                                          
  
  school.recruiter_id = session[:recruiter]
  school.save
  
  redirect "/schools/#{school.id}/school"
end


get '/schools/:id/school/?' do
  auth_recruiter
  @state = State.all
  @recruiter = Recruiter.get(session[:recruiter])
  @school = School.get(params[:id])
  erb :"/schools/school"
end




# ----------------  Recruiter Reportas (2)  --------------------

get '/schools/:id/school_report/?' do
  auth_recruiter
  @school = School.get(params[:id])
  @recruiter = Recruiter.get(params[:recruiter_id])
  @school.presentations = Presentation.all(:school_id => @school.id)
  @school.students = Student.all(:school_password => @school.school_password, :school_password.not => '', :class_date => params[:presentation])
     
  @school.class_date = params[:presentation]
  @school.save
  
  erb :"/schools/school_report"
  
end

get '/schools/:id/summary_report/?' do
  auth_recruiter
  @school = School.get(params[:id])
  @recruiter = Recruiter.get(params[:recruiter_id])
  @school.presentations = Presentation.all(:school_id => @school.id, :class_date => params[:presentation])
  @school.students = Student.all(:school_password => @school.school_password)
  @grade = Grade.all(:school_id => @school.id, :class_date => params[:presentation])
  
  @school.students.each do |student|

    student.college = 0
    student.gr12 = 0
    student.gr11 = 0
    student.gr10 = 0
    student.gr9 = 0
    student.other = 0
    student.unknown = 0

  end
    
  @school.students.each do |student|
    
    # if student.class_date = Grade.class_date
    
      if (student.grade == 'College')
        student.college = (student.college + 1)
      elsif (student.grade == '12')
        student.gr12 = (student.gr12 + 1)
      elsif (student.grade == '11')
        student.gr11 = (student.gr11 + 1)
      elsif (student.grade == '10')
        student.gr10 = (student.gr10 + 1)
      elsif (student.grade == '9')
        student.gr9 = (student.gr9 + 1)
      elsif (student.grade == 'Other')
        student.other = (student.other + 1)
      else (student.grade == 'Select one')
        student.unknown = (student.unknown + 1)
      end
    
    student.save
    
    # end

  end
  
   
  erb :'/schools/summary_report', layout: false
  
end

   
#   @school.students.each do |student|
#
#     student.sa = 0
#     student.ag = 0
#     student.dg = 0
#     student.da = 0
#     student.na = 0
#
#     if (student.question_1 == 'Strongly Agree')
#       student.sa = (student.ag + 1)
#     elsif (student.question_1 == 'Agree')
#       student.ag = (student.ag + 1)
#     elsif (student.question_1 == 'Disagree')
#       student.dg = (student.dg + 1)
#     elsif (student.question_1 == 'Strongly Disagree')
#       student.da = (student.da + 1)
#     else (student.question_1 == 'Select one')
#       student.na = (student.na. + 1)
#     end
#
#     if (student.question_2 == 'Strongly Agree')
#       student.sa = (student.sa + 1)
#     elsif (student.question_2 == 'Agree')
#       student.ag = (student.ag + 1)
#     elsif (student.question_2 == 'Disagree')
#       student.dg = (student.dg + 1)
#     elsif (student.question_2 == 'Strongly Disagree')
#       student.da = (student.da + 1)
#     else (student.question_2 == 'Select one')
#       student.na = (student.na + 1)
#     end
#
#     if (student.question_3 == 'Strongly Agree')
#       student.sa = (student.sa + 1)
#     elsif (student.question_3 == 'Agree')
#       student.ag = (student.ag + 1)
#     elsif (student.question_3 == 'Disagree')
#       student.dg = (student.dg + 1)
#     elsif (student.question_3 == 'Strongly Disagree')
#       student.da = (student.da + 1)
#     else (student.question_3 == 'Select one')
#       student.na = (student.na + 1)
#     end
#
#     if (student.question_4 == 'Strongly Agree')
#       student.sa = (student.sa + 1)
#     elsif (student.question_4 == 'Agree')
#       student.ag = (student.ag + 1)
#     elsif (student.question_4 == 'Disagree')
#       student.dg = (student.dg + 1)
#     elsif (student.question_4== 'Strongly Disagree')
#       student.da = (student.da + 1)
#     else (student.question_4 == 'Select one')
#       student.na = (student.na + 1)
#     end
#
#     if (student.question_5 == 'Strongly Agree')
#       student.sa = (student.sa + 1)
#     elsif (student.question_5 == 'Agree')
#       student.ag = (student.ag + 1)
#     elsif (student.question_5 == 'Disagree')
#       student.dg = (student.dg + 1)
#     elsif (student.question_5 == 'Strongly Disagree')
#       student.da = (student.da + 1)
#     else (student.question_5 == 'Select one')
#       student.na = (student.na + 1)
#     end
#
#     if (student.question_6 == 'Strongly Agree')
#       student.sa = (student.sa + 1)
#     elsif (student.question_6 == 'Agree')
#       student.ag = (student.ag + 1)
#     elsif (student.question_6 == 'Disagree')
#       student.dg = (student.dg + 1)
#     elsif (student.question_6 == 'Strongly Disagree')
#       student.da = (student.da + 1)
#     else (student.question_6 == 'Select one')
#       student.na = (student.na + 1)
#     end
#
#     if (student.question_7 == 'Strongly Agree')
#       student.sa = (student.sa + 1)
#     elsif (student.question_7 == 'Agree')
#       student.ag = (student.ag + 1)
#     elsif (student.question_7 == 'Disagree')
#       student.dg = (student.dg + 1)
#     elsif (student.question_7 == 'Strongly Disagree')
#       student.da = (student.da + 1)
#     else (student.question_7 == 'Select one')
#       student.na = (student.na + 1)
#     end
#
#     if (student.question_8 == 'Strongly Agree')
#       student.sa = (student.sa + 1)
#     elsif (student.question_8 == 'Agree')
#       student.ag = (student.ag + 1)
#     elsif (student.question_8 == 'Disagree')
#       student.dg = (student.dg + 1)
#     elsif (student.question_8== 'Strongly Disagree')
#       student.da = (student.da + 1)
#     else (student.question_8 == 'Select one')
#       student.na = (student.na + 1)
#     end
#
#     if (student.question_9 == 'Strongly Agree')
#       student.sa = (student.sa + 1)
#     elsif (student.question_9 == 'Agree')
#       student.ag = (student.ag + 1)
#     elsif (student.question_9 == 'Disagree')
#       student.dg = (student.dg + 1)
#     elsif (student.question_9 == 'Strongly Disagree')
#       student.da = (student.da + 1)
#     else (student.question_9 == 'Select one')
#       student.na = (student.na + 1)
#     end
#
#     if (student.question_10 == 'Strongly Agree')
#       student.sa = (student.sa + 1)
#     elsif (student.question_10 == 'Agree')
#       student.ag = (student.ag + 1)
#     elsif (student.question_10 == 'Disagree')
#       student.dg = (student.dg + 1)
#     elsif (student.question_10 == 'Strongly Disagree')
#       student.da = (student.da + 1)
#     else (student.question_10 == 'Select one')
#       student.na = (student.na + 1)
#     end
#
#     if (student.question_11 == 'Strongly Agree')
#       student.sa = (student.sa + 1)
#     elsif (student.question_11 == 'Agree')
#       student.ag = (student.ag + 1)
#     elsif (student.question_11 == 'Disagree')
#       student.dg = (student.dg + 1)
#     elsif (student.question_11 == 'Strongly Disagree')
#       student.da = (student.da + 1)
#     else (student.question_11 == 'Select one')
#       student.na = (student.na + 1)
#     end
#
#     if (student.question_12 == 'Strongly Agree')
#       student.sa = (student.sa + 1)
#     elsif (student.question_12 == 'Agree')
#       student.ag = (student.ag + 1)
#     elsif (student.question_12 == 'Disagree')
#       student.dg = (student.dg + 1)
#     elsif (student.question_12 == 'Strongly Disagree')
#       student.da = (student.da + 1)
#     else (student.question_12 == 'Select one')
#       student.na = (student.na + 1)
#     end
#
#     student.save
    
  
         
 

#   erb :'/schools/summary_report', layout: false
#
# end






# post '/schools/:id/summary_report/?' do
#
#   auth_recruiter
#   school = School.get(params[:id])
#   recruiter = Recruiter.get(params[:recruiter_id])
#   school.presentations = Presentation.all(:school_id => @school.id)
#   school.students = Student.all(:school_password => @school.school_password, :school_password.not => '')
#
#
#
#
#
# end
#





get '/schools/:id/school_report/csv/?' do
  
  auth_recruiter
  @school = School.get(params[:id])
  @recruiter = Recruiter.get(params[:recruiter_id])
  @school.presentations = Presentation.all(:school_id => @school.id, :class_date => params[:presentation])
  @school.students = Student.all(:school_password => @school.school_password, :school_password.not => '')
  
  erb :'/schools/summary_report', layout: false
  
  # headers "Content-Disposition" => "attachment;filename=#summary_report.csv",
  #   "Content-Type" => "application/octet-stream"
  # result = ""
  # @school.students.each do |student|
  #   result << "/arng/schools/#{@school.id}/summary_report"
  # end
end







get '/schools/:id/ind_report/?' do
  
  auth_recruiter
  @school = School.get(params[:id])
  @recruiter = Recruiter.get(params[:recruiter_id])
  @school.presentations = Presentation.all(:school_id => @school.id)
  @school.students = Student.all(:school_password => @school.school_password, :school_password.not => '')
  
  erb :'arng/schools/ind_report', layout: false
 
end

post '/schools/:id/ind_report/?' do
  auth_recruiter
  @school = School.get(params[:id])
  @recruiter = Recruiter.get(params[:recruiter_id])
  @school.students = Student.all(:school_password => @school.school_password, :school_password.not => '', :class_date => params[:presentation])
  
  PDFKit.configure do |config|
    config.default_options = {
      :print_media_type => true,
      :page_size        => 'Letter',
      :margin_top       => '0.25in',
      :margin_right     => '0.25in',
      :margin_bottom    => '0.25in',
      :margin_left      => '0.25in',
      :javascript_delay => 001
    }
  end
  
  content_type 'application/pdf'
  
  if settings.development?
    kit = PDFKit.new("http://localhost:4567/arng/schools/#{@school.id}/ind_report")
  elsif settings.production?
    kit = PDFKit.new("https://www.ecareerdirection.com/arng/schools/#{@school.id}/ind_report")
  end
   
  pdf = kit.to_pdf
  
end





#  -------------------  ARNG Schools ---------------------

# get '/arng/schools/:id/?' do
#   auth_recruiter
#   @recruiter = Recruiter.all
#   @state = State.all
#   @school = School.get(params[:id])
#   erb :"/arng/schools/edit_school"
# end

get '/schools/:id/edit_admin/?' do
  auth_admin
  @recruiter = Recruiter.all
  @state = State.all
  @school = School.get(params[:id])
  erb :"/schools/edit_school_arng"
end

post '/schools/:id/edit_admin/?' do
  auth_admin
  recruiter = Recruiter.all
  state = State.all
  school = School.get(params[:id])
  school.update(
    :school_id              => params[:school_id],
    :date_modified          => params[:date_modified],
    :first_name             => params[:first_name],
    :last_name              => params[:last_name],
    :email                  => params[:email],
    :phone                  => params[:phone],
    :school_name            => params[:school_name],
    :address1               => params[:address1],
    :address2               => params[:address2],
    :city                   => params[:city],
    :state                  => params[:state],
    :zip                    => params[:zip],
    :school_password        => params[:school_password],         
    :class_date             => params[:class_date],                                                           
    :recruiter_id           => params[:recruiter_id]                         
  )                                                                          

  redirect "/schools/#{params[:id]}/school"

end

get '/schools/:id/edit/?' do
  auth_recruiter
  @recruiter = Recruiter.all
  @state = State.all
  @school = School.get(params[:id])
  
  erb :"/schools/edit_school_arng"
end

post '/schools/:id/edit/?' do
  auth_recruiter
  recruiter = Recruiter.all
  state = State.all
  school = School.get(params[:id])
  school.update(
    :school_id              => params[:school_id],
    :date_modified          => params[:date_modified],
    :first_name             => params[:first_name],
    :last_name              => params[:last_name],
    :email                  => params[:email],
    :phone                  => params[:phone],
    :school_name            => params[:school_name],
    :address1               => params[:address1],
    :address2               => params[:address2],
    :city                   => params[:city],
    :state                  => params[:state],
    :zip                    => params[:zip],
    :school_password        => params[:school_password],         
    :class_date             => params[:class_date],                                                           
    :recruiter_id           => params[:recruiter_id]                         
  )                                                                          
  
  redirect "/schools/#{params[:id]}/school"
  
end

get '/register/?' do
  auth_recruiter
  @school = School.all
  unless params[:zip]
    @results = []
  else
    @results = School.all(school_zip: params[:zip].strip.downcase)
  end
  erb :"/register"
end

get '/schools/:id/delete/?' do
  auth_recruiter
  school = School.get(params[:id])
  school.destroy
  redirect "/schools/schools"
end


