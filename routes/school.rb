get '/schools/schools/?' do
  auth_recruiter
	@school = School.all(order: [:updated_at.desc], limit: 100)
  
	if params[:search] && !params[:search].nil?
		@school = School.all(:school_zip.like => "%#{params[:search]}%", limit: 30) 
  else
		@school = School.all(:school_name.not => nil, order: [:updated_at.desc], limit: 100)
	end
  
	erb :'/schools/schools'
end





get '/schools/create/?' do
  auth_recruiter
  @state = State.all
  @admin = Admin.all
  @recruiter = Recruiter.all
  @school = School.new
  erb :'/schools/new_school'
end

post '/schools/create/?' do
  auth_recruiter
  state = State.all
  admin = Admin.all
  recruiter = Recruiter.all
  school = School.create(
    :school_id              => params[:school_id],
    :date_modified          => params[:date_modified],
    :first_name             => params[:first_name],
    :middle_initial         => params[:middle_initial],
    :last_name              => params[:last_name],
    :school_name            => params[:school_name],
    :school_address1        => params[:school_address1],
    :school_address2        => params[:school_address2],
    :school_city            => params[:school_city],
    :school_state           => params[:school_state],
    :school_zip             => params[:school_zip],
    :school_password        => params[:school_password],
    :mail_address1          => params[:mail_address1],
    :mail_address2          => params[:mail_address2],
    :mail_city              => params[:mail_city],
    :mail_state             => params[:mail_state],
    :mail_zip               => params[:mail_zip],
    :phone                  => params[:phone],
    :fax                    => params[:fax],
    :ng_rep                 => params[:ng_rep],
    :email                  => params[:email],
    :arng_email             => params[:arng_email],
    :number_seniors         => params[:number_seniors],
    :recruiter_id           => params[:recruiter_id]
  )  
   
  redirect "/schools/#{school.id}/school"
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
    :middle_initial         => params[:middle_initial],
    :last_name              => params[:last_name],
    :school_name            => params[:school_name],
    :school_address1        => params[:school_address1],
    :school_address2        => params[:school_address2],
    :school_city            => params[:school_city],
    :school_state           => params[:school_state],
    :school_zip             => params[:school_zip],
    :school_password        => params[:school_password],
    :mail_address1          => params[:mail_address1],
    :mail_address2          => params[:mail_address2],
    :mail_city              => params[:mail_city],
    :mail_state             => params[:mail_state],
    :mail_zip               => params[:mail_zip],
    :phone                  => params[:phone],
    :fax                    => params[:fax],
    :ng_rep                 => params[:ng_rep],
    :email                  => params[:email],
    :arng_email             => params[:arng_email],
    :number_seniors         => params[:number_seniors],
    :recruiter_id           => params[:recruiter_id]
  )
  
   school.recruiter_id == session[:recruiter]
   school.save
  
  redirect "/schools/#{school.id}/school"
end


get '/schools/:id/school/?' do
  auth_recruiter
  @state = State.all
  @recruiter = Recruiter.get(params[:recruiter_id])
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
  @school.students = Student.all(:school_password => @school.school_password, :school_password.not => '')
  
  erb :'/schools/summary_report', layout: false
  
end

post '/schools/:id/summary_report/?' do
  
  auth_recruiter
  @school = School.get(params[:id])
  @recruiter = Recruiter.get(params[:recruiter_id])
  @school.presentations = Presentation.all(:school_id => @school.id)
  @school.students = Student.all(:school_password => @school.school_password, :school_password.not => '')
  
  PDFKit.configure do |config|
    config.default_options = {
      :print_media_type => true,
      :page_size        => 'Letter',
      :margin_top       => '0.25in',
      :margin_right     => '0.25in',
      :margin_bottom    => '0.25in',
      :margin_left      => '0.25in'
    }
  end
  
  content_type 'application/pdf'
  
  if settings.development?
    kit = PDFKit.new("http://localhost:4567/arng/schools/#{@school.id}/summary_report")
  elsif settings.production?
    kit = PDFKit.new("https://www.ecareerdirection.com/arng/schools/#{@school.id}/summary_report")
  end
    
  pdf = kit.to_pdf
  
end






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
    :middle_initial         => params[:middle_initial],
    :last_name              => params[:last_name],
    :school_name            => params[:school_name],
    :school_address1        => params[:school_address1],
    :school_address2        => params[:school_address2],
    :school_city            => params[:school_city],
    :school_state           => params[:school_state],
    :school_zip             => params[:school_zip],
    :school_password        => params[:school_password],
    :phone                  => params[:phone],
    :fax                    => params[:fax],
    :ng_rep                 => params[:ng_rep],
    :email                  => params[:email],
    :arng_email             => params[:arng_email],
    :number_seniors         => params[:number_seniors],
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
    :middle_initial         => params[:middle_initial],
    :last_name              => params[:last_name],
    :school_name            => params[:school_name],
    :school_address1        => params[:school_address1],
    :school_address2        => params[:school_address2],
    :school_city            => params[:school_city],
    :school_state           => params[:school_state],
    :school_zip             => params[:school_zip],
    :school_password        => params[:school_password],
    :phone                  => params[:phone],
    :fax                    => params[:fax],
    :ng_rep                 => params[:ng_rep],
    :email                  => params[:email],
    :arng_email             => params[:arng_email],
    :number_seniors         => params[:number_seniors],
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


