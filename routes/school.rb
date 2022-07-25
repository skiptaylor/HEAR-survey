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




# ----------------  Recruiter Reportas (1)  --------------------

get '/schools/:id/school_report/?' do
  auth_recruiter
  @school = School.get(params[:id])
  @recruiter = Recruiter.get(params[:recruiter_id])
  @school.presentations = Presentation.all(:school_password => @school.school_password)
  @school.students = Student.all(:school_password => @school.school_password, :class_date => params[:presentation])
     
  @school.class_date = params[:presentation]
  @school.save
    
  erb :"/schools/school_report"
  
end

# post '/schools/:id/school_report/?' do
#   auth_recruiter
#   school = School.get(params[:id])
#   recruiter = Recruiter.get(params[:recruiter_id])
#   school.presentations = Presentation.all(:school_id => @school.id, :class_date => params[:presentation])
#   school.students = Student.all(:school_password => @school.school_password, :school_password.not => '', :class_date => params[:presentation])
#
#   redirect "/schools/#{params[:id]}/report"
#
# end






get '/schools/:id/summary_report/?' do
  auth_recruiter
  @school = School.get(params[:id])
  @recruiter = Recruiter.get(params[:recruiter_id])
  @school.presentations = Presentation.all(:school_password => @school.school_password, :class_date => params[:presentation])
  @school.students = Student.all(:school_password => @school.school_password)
  @grade = Grade.all(:school_password => @school.school_password, :class_date => params[:presentation])
  
  @stud_gradec = 0
  @stud_grade12 = 0
  @stud_grade11 = 0
  @stud_grade10 = 0
  @stud_grade9 = 0
  @stud_gradeother = 0
  @stud_gradeunknown = 0
  
  @school.students.each do |student|
    
      if (student.grade == 'College')
        @stud_gradec = (@stud_gradec + 1)
      elsif (student.grade == 'gr12')
        @stud_grade12 = (@stud_grade12 + 1)
      elsif (student.grade == 'gr11')
        @stud_grade11 = (@stud_grade11 + 1)
      elsif (student.grade == 'gr10')
        @stud_grade10 = (@stud_grade10 + 1)
      elsif (student.grade == 'gr9')
        @stud_graderade9 = (@stud_grade9 + 1)
      elsif (student.grade == 'Other')
        @stud_gradeother = (@stud_gradeother + 1)
      else (student.grade == 'Select one')
        @stud_gradeunknown = (@stud_gradeunknown + 1)
      end

  end
   
    @answer1_sa = 0
    @answer1_ag = 0
    @answer1_dg = 0
    @answer1_da = 0
    @answer1_na = 0
    
    @answer2_sa = 0
    @answer2_ag = 0
    @answer2_dg = 0
    @answer2_da = 0
    @answer2_na = 0
    
    @answer3_sa = 0
    @answer3_ag = 0
    @answer3_dg = 0
    @answer3_da = 0
    @answer3_na = 0
    
    @answer4_sa = 0
    @answer4_ag = 0
    @answer4_dg = 0
    @answer4_da = 0
    @answer4_na = 0
    
    @answer5_sa = 0
    @answer5_ag = 0
    @answer5_dg = 0
    @answer5_da = 0
    @answer5_na = 0
    
    @answer6_sa = 0
    @answer6_ag = 0
    @answer6_dg = 0
    @answer6_da = 0
    @answer6_na = 0
    
    @answer7_sa = 0
    @answer7_ag = 0
    @answer7_dg = 0
    @answer7_da = 0
    @answer7_na = 0
    
    @answer8_sa = 0
    @answer8_ag = 0
    @answer8_dg = 0
    @answer8_da = 0
    @answer8_na = 0
    
    @answer9_sa = 0
    @answer9_ag = 0
    @answer9_dg = 0
    @answer9_da = 0
    @answer9_na = 0
    
    @answer10_sa = 0
    @answer10_ag = 0
    @answer10_dg = 0
    @answer10_da = 0
    @answer10_na = 0
    
    @answer11_sa = 0
    @answer11_ag = 0
    @answer11_dg = 0
    @answer11_da = 0
    @answer11_na = 0
    
    @answer12_sa = 0
    @answer12_ag = 0
    @answer12_dg = 0
    @answer12_da = 0
    @answer12_na = 0
    
  @school.students.each do |student|

    if (student.question_1 == 'Strongly Agree')
      @answer1_sa = (@answer1_sa + 1)
    elsif (student.question_1 == 'Agree')
      @answer1_ag = (@answer1_ag + 1)
    elsif (student.question_1 == 'Disagree')
      @answer1_dg = (@answer1_dg + 1)
    elsif (student.question_1 == 'Strongly Disagree')
      @answer1_da = (@answer1_da + 1)
    else (student.question_1 == 'Select one')
      @answer1_na = (@answer1_na + 1)
    end

    if (student.question_2 == 'Strongly Agree')
      @answer2_sa = (@answer2_sa + 1)
    elsif (student.question_2 == 'Agree')
      @answer2_ag = (@answer2_ag + 1)
    elsif (student.question_2 == 'Disagree')
      @answer2_dg = (@answer2_dg + 1)
    elsif (student.question_2 == 'Strongly Disagree')
      @answer2_da = (@answer2_da + 1)
    else (student.question_2 == 'Select one')
      @answer2_na = (@answer2_na + 1)
    end

    if (student.question_3 == 'Strongly Agree')
      @answer3_sa = (@answer3_sa + 1)
    elsif (student.question_3 == 'Agree')
      @answer3_ag = (@answer3_ag + 1)
    elsif (student.question_3 == 'Disagree')
      @answer3_dg = (@answer3_dg + 1)
    elsif (student.question_3 == 'Strongly Disagree')
      @answer3_da = (@answer3_da + 1)
    else (student.question_3 == 'Select one')
      @answer3_na = (@answer3_na + 1)
    end

    if (student.question_4 == 'Strongly Agree')
      @answer4_sa = (@answer4_sa + 1)
    elsif (student.question_4 == 'Agree')
      @answer4_ag = (@answer4_ag + 1)
    elsif (student.question_4 == 'Disagree')
      @answer4_dg = (@answer4_dg + 1)
    elsif (student.question_4 == 'Strongly Disagree')
      @answer4_da = (@answer4_da + 1)
    else (student.question_4 == 'Select one')
      @answer4_na = (@answer4_na + 1)
    end

    if (student.question_5 == 'Strongly Agree')
      @answer5_sa = (@answer5_sa + 1)
    elsif (student.question_5 == 'Agree')
      @answer5_ag = (@answer5_ag + 1)
    elsif (student.question_5 == 'Disagree')
      @answer5_dg = (@answer5_dg + 1)
    elsif (student.question_5 == 'Strongly Disagree')
      @answer5_da = (@answer5_da + 1)
    else (student.question_5 == 'Select one')
      @answer5_na = (@answer5_na + 1)
    end

    if (student.question_6 == 'Strongly Agree')
      @answer6_sa = (@answer6_sa + 1)
    elsif (student.question_6 == 'Agree')
      @answer6_ag = (@answer6_ag + 1)
    elsif (student.question_6 == 'Disagree')
      @answer6_dg = (@answer6_dg + 1)
    elsif (student.question_6 == 'Strongly Disagree')
      @answer6_da = (@answer6_da + 1)
    else (student.question_6 == 'Select one')
      @answer6_na = (@answer6_na + 1)
    end

    if (student.question_7 == 'Strongly Agree')
      @answer7_sa = (@answer7_sa + 1)
    elsif (student.question_7 == 'Agree')
      @answer7_ag = (@answer7_ag + 1)
    elsif (student.question_7 == 'Disagree')
      @answer7_dg = (@answer7_dg + 1)
    elsif (student.question_7 == 'Strongly Disagree')
      @answer7_da = (@answer7_da + 1)
    else (student.question_7 == 'Select one')
      @answer7_na = (@answer7_na + 1)
    end

    if (student.question_8 == 'Strongly Agree')
      @answer8_sa = (@answer8_sa + 1)
    elsif (student.question_8 == 'Agree')
      @answer8_ag = (@answer8_ag + 1)
    elsif (student.question_8 == 'Disagree')
      @answer8_dg = (@answer8_dg + 1)
    elsif (student.question_8 == 'Strongly Disagree')
      @answer8_da = (@answer8_da + 1)
    else (student.question_8 == 'Select one')
      @answer8_na = (@answer8_na + 1)
    end

    if (student.question_9 == 'Strongly Agree')
      @answer9_sa = (@answer9_sa + 1)
    elsif (student.question_9 == 'Agree')
      @answer9_ag = (@answer9_ag + 1)
    elsif (student.question_9 == 'Disagree')
      @answer9_dg = (@answer9_dg + 1)
    elsif (student.question_9 == 'Strongly Disagree')
      @answer9_da = (@answer9_da + 1)
    else (student.question_9 == 'Select one')
      @answer9_na = (@answer9_na + 1)
    end

    if (student.question_10 == 'Strongly Agree')
      @answer10_sa = (@answer10_sa + 1)
    elsif (student.question_10 == 'Agree')
      @answer10_ag = (@answer10_ag + 1)
    elsif (student.question_10 == 'Disagree')
      @answer10_dg = (@answer10_dg + 1)
    elsif (student.question_10 == 'Strongly Disagree')
      @answer10_da = (@answer10_da + 1)
    else (student.question_10 == 'Select one')
      @answer10_na = (@answer10_na + 1)
    end

    if (student.question_11 == 'Strongly Agree')
      @answer11_sa = (@answer11_sa + 1)
    elsif (student.question_11 == 'Agree')
      @answer11_ag = (@answer11_ag + 1)
    elsif (student.question_11 == 'Disagree')
      @answer11_dg = (@answer11_dg + 1)
    elsif (student.question_11 == 'Strongly Disagree')
      @answer11_da = (@answer11_da + 1)
    else (student.question_11 == 'Select one')
      @answer11_na = (@answer11_na + 1)
    end

    if (student.question_12 == 'Strongly Agree')
      @answer12_sa = (@answer12_sa + 1)
    elsif (student.question_12 == 'Agree')
      @answer12_ag = (@answer12_ag + 1)
    elsif (student.question_12 == 'Disagree')
      @answer12_dg = (@answer12_dg + 1)
    elsif (student.question_12 == 'Strongly Disagree')
      @answer12_da = (@answer12_da + 1)
    else (student.question_12 == 'Select one')
      @answer12_na = (@answer12_na + 1)
    end
    
  end
    erb :'/schools/summary_report', layout: false
  
end

# post '/schools/:id/summary_report/?' do
#
#   auth_recruiter
#   school = School.get(params[:id])
#   recruiter = Recruiter.get(params[:recruiter_id])
#   school.presentations = Presentation.all(:school_id => @school.id)
#   school.students = Student.all(:school_password => @school.school_password, :school_password.not => '')
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







# get '/schools/:id/ind_report/?' do
#
#   auth_recruiter
#   @school = School.get(params[:id])
#   @recruiter = Recruiter.get(params[:recruiter_id])
#   @school.presentations = Presentation.all(:school_id => @school.id)
#   @school.students = Student.all(:school_password => @school.school_password, :school_password.not => '')
#
#   erb :'arng/schools/ind_report', layout: false
#
# end
#
# post '/schools/:id/ind_report/?' do
#   auth_recruiter
#   @school = School.get(params[:id])
#   @recruiter = Recruiter.get(params[:recruiter_id])
#   @school.students = Student.all(:school_password => @school.school_password, :school_password.not => '', :class_date => params[:presentation])
#
#   PDFKit.configure do |config|
#     config.default_options = {
#       :print_media_type => true,
#       :page_size        => 'Letter',
#       :margin_top       => '0.25in',
#       :margin_right     => '0.25in',
#       :margin_bottom    => '0.25in',
#       :margin_left      => '0.25in',
#       :javascript_delay => 001
#     }
#   end
#
#   content_type 'application/pdf'
#
#   if settings.development?
#     kit = PDFKit.new("http://localhost:4567/arng/schools/#{@school.id}/ind_report")
#   elsif settings.production?
#     kit = PDFKit.new("https://www.ecareerdirection.com/arng/schools/#{@school.id}/ind_report")
#   end
#
#   pdf = kit.to_pdf
#
# end





#  ------------------- Schools ---------------------

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

# get '/register/?' do
#   auth_recruiter
#   @school = School.all
#   unless params[:zip]
#     @results = []
#   else
#     @results = School.all(school_zip: params[:zip].strip.downcase)
#   end
#   erb :"/register"
# end

get '/schools/:id/delete/?' do
  auth_recruiter
  school = School.get(params[:id])
  school.destroy
  redirect "/schools/schools"
end


