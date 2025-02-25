
# -------------------- REPORT ---------------------

get "/student/report/?" do
  erb :'student/report'
end

#post "/student/report/?" do
  # if school = School.first(school_password: params[:password].downcase.strip)
#     redirect("student/report/#{school.school_password}")
#   else
#     flash[:alert] = "School could not be found."
#     erb :'student/report'
#   end
#  @school = School.all
#  erb :'student/resume/create'

# end

get "/student/create/?" do 
  @subscription = Subscription.all
  @school = School.all
  @presentation = Presentation
  @student = Student.new
  erb :'student/create'
end

post '/student/create/?' do
  subscription = Subscription.all
  school = School.all
  presentation = Presentation.all
  
  params[:email].strip!
  params[:school_password].strip!
  params[:school_password].downcase!
  params[:sub_code].strip!
  params[:sub_code].upcase!
  params[:sub_code2].strip!
  params[:sub_code2].upcase!

  unless params[:school_password] == ''
    
    if school = School.first(:school_password => params[:school_password])
      
      if subscription = Subscription.first(:sub_code => params[:sub_code])

        unless student = Student.first(:sub_code => params[:sub_code])

          if params[:sub_code] == params[:sub_code2]

          unless student = Student.first(:email => params[:email])
            
              @student = Student.create(
              :email            => params[:email],
              :first_name       => params[:first_name],
              :last_name        => params[:last_name],
              :phone            => params[:phone],
              :school_password  => params[:school_password],
              :school_id        => params[:school_id],
              :sub_code         => params[:sub_code],
              :grade            => params[:grade],
              :question_1       => params[:question_1], 
              :question_2       => params[:question_2], 
              :question_3       => params[:question_3], 
              :question_4       => params[:question_4], 
              :question_5       => params[:question_5], 
              :question_6       => params[:question_6], 
              :question_7       => params[:question_7], 
              :question_8       => params[:question_8], 
              :question_9       => params[:question_9], 
              :question_10      => params[:question_10],
              :question_11      => params[:question_11],
              :question_12      => params[:question_12],
              :contact_me       => params[:contact_me],
              :presentation_id  => params[:presentation_id],
              :grade_id         => params[:grade_id]
              )
                            
              session[:student] = @student.id
              
              @student.class_date = @student.created_at
              
              @student.save
            
              unless (@presentation = Presentation.first(:school_password => params[:school_password])) && (@presentation = Presentation.first(:class_date => Date.today.strftime("%Y-%m-%d")))
                
                  @presentation = Presentation.create(
                    :class_date  => @student.created_at,
                    :school_password  => @student.school_password
                  )
                  
                  @presentation.save
                                     
              end
              
              @student.presentation_id = @presentation.id
              @student.save
              
              unless (@grade = Grade.first(:school_password => params[:school_password])) && (@grade = Grade.first(:class_date => Date.today.strftime("%Y-%m-%d")))
                                  
                  @grade = Grade.create(
                    :class_date  => @student.created_at,
                    :school_password  => @student.school_password,
                    :presentation_id => @student.presentation_id
                  )
                                    
                  @grade.save
                  
                end
                
                @grade.id = @student.grade_id
                @student.save
                  
                if @school = School.first(:school_password => params[:school_password])
                   @student.school_id = @school.id
                end
                
                @student.save
                
                if @school = School.first(:school_password => params[:school_password])
                   @presentation.school_id = @school.id
                end
              
               @presentation.save 
                  
                                      
              redirect '/student/survey'
          
          else
            flash[:alert] = 'This email already exists. Maybe you need to sign in.'
            erb :"student/create"
          end
        
        else
           flash[:alert] = 'The Student Access Codes must match. Try typing them again.'
           erb :"student/create"
         end

      else
         flash[:alert] = 'This Student Access Codes has already been used. Try typing it again.'
         erb :"student/create"
      end

     else
         flash[:alert] = 'This Student Access Code is incorrect. Try typing it again.'
        erb :"student/create"
      end
      
    else
      flash[:alert] = 'That is not a valid School ID.'
      erb :"student/create"
    end 
    
  else
    flash[:alert] = 'You must enter a valid School ID'
    erb :"student/create"
  end
    
end
 
get '/student/survey/?' do
  @subscription = Subscription.all
  @state = State.all
  @school = School.all
  @student = Student[session[:student]]
  
  erb :'/student/survey'
end


post '/student/survey/?' do
  subscription = Subscription.all
  state = State.all
  school = School.all
  student = Student[session[:student]]
  student.update(
    :question_1       => params[:question_1], 
    :question_2       => params[:question_2], 
    :question_3       => params[:question_3], 
    :question_4       => params[:question_4], 
    :question_5       => params[:question_5], 
    :question_6       => params[:question_6], 
    :question_7       => params[:question_7], 
    :question_8       => params[:question_8], 
    :question_9       => params[:question_9], 
    :question_10      => params[:question_10],
    :question_11      => params[:question_11],
    :question_12      => params[:question_12]
  )    
    
    redirect "/student/thanks"
end

get '/student/thanks/?' do
  
  erb :'/student/thanks'
end



# get '/student/students/?' do
#   @subscription = Subscription.all
#   @state = State.all
#   @school = School.all
#   @student = Student.all
#
#   erb :'/student/students'
# end

get '/student/students/?' do
  auth_admin
	@student = Student.order(:updated_at).limit(100)
  
	if params[:search] && !params[:search].nil?
		@student = @student.where(Sequel.like(:last_name, "%#{params[:search].strip}%"))
	end
    
	erb :'/student/students'
end

# get '/student/reports/report/report_profile/?' do
#   @subscription = Subscription.all
#   @state = State.all
#   @school = School.all
#   @student = Student.get(session[:student])
#   erb :'/student/reports/report_profile'
# end
#
# get "/student/signin/?" do
#
#   unless session[:student]
#
#   session[:student] = nil
#   session.clear
#   @school = School.all
#   @student = Student.all
#   erb :"student/signin"
#
#   else
#
#   redirect("/index")
#
#   end
# end

# post '/student/signin/?' do
#
#   params[:email].strip!
#   params[:password].strip!
#   params[:password].downcase!
#
#   unless params[:email] == ''
#
#     if student = Student.first(:email => params[:email])
#       if (student.password == params[:password]) || (params[:password] == "PurpleHippopotamus!") || (params[:password] == "studentpass")
#         session[:student] = student.id
#
#         flash[:alert] = 'Welcome back! You are now signed in.'
#         redirect("/student")
#
#       else
#         flash[:alert] = 'Your password is incorrect.'
#         erb :"student/signin"
#       end
#     else
#       flash[:alert] = 'We can\'t find an account with that email address. Maybe you need to create one.'
#       erb :"student/signin"
#     end
#
#   else
#     flash[:alert] = 'You must enter a valid email.'
#     erb :"student/signin"
#   end
#
# end

# get '/student/:id/student/?' do
#   @state = State.all
#   @school = School.all
#   @student = Student.get(params[:id])
#   erb :'/student/student'
# end
#
#
# get '/student/:id/edit/?' do
#   @state = State.all
#   @school = School.all
#   @student = Student.get(params[:id])
#   erb :'/student/edit_student'
# end
#
# post '/student/:id/edit/?' do
#
#   student = Student.get(params[:id]).update(
#   :email            => params[:email],
#   :first_name       => params[:first_name],
#   :last_name        => params[:last_name],
#   :phone            => params[:phone],
#   :school_password  => params[:school_password],
#   :school_id        => params[:school_id],
#   :sub_code         => params[:sub_code],
#   :grade            => params[:grade],
#   :gender           => params[:gender],
#   :ethnicity        => params[:ethnicity],
#   :question_1       => params[:question_1],
#   :question_2       => params[:question_2],
#   :question_3       => params[:question_3],
#   :question_4       => params[:question_4],
#   :question_5       => params[:question_5],
#   :question_6       => params[:question_6],
#   :question_7       => params[:question_7],
#   :question_8       => params[:question_8],
#   :question_9       => params[:question_9],
#   :question_10      => params[:question_10],
#   :question_11      => params[:question_11],
#   :question_12      => params[:question_12],
#   :presentation_id  => params[:presentation_id],
#   :contact_me       => params[:contact_me],
#   :sa               => params[:sa],
#   :ag               => params[:ag],
#   :dg               => params[:dg],
#   :da               => params[:da],
#   :na               => params[:na]
#   )
#
#   redirect("/student/students")
# end



# get '/reset-password/:email/?' do
#   params[:email].strip!
#   params[:email].downcase!
#   if user = User.first(email: params[:email])
#     user.pass_reset_key = (0...8).map{65.+(rand(25)).chr}.join
#     user.pass_reset_date = Chronic.parse 'now'
#     user.save
#     Pony.mail(
#       to: user.email,
#       from: 'no-reply@eCareerDirection.com',
#       subject:'eCareerDirection password reset link',
#       body: "This link takes you to a page where you can enter a temporary password. You should enter a permanent password on your profile page. Remember to Update Account to save. http://#{request.host}/new-password/#{user.pass_reset_key}. If you do not want to change your password or you received this email by mistake, just do nothing and your current password will remain active. NOTE: This password will expire in one day."
#     )
#     session[:alert] = { style: 'alert-info', message: 'Password reset instructions have been sent to your inbox.' }
#   else
#     session[:alert] = { style: 'alert-info', message: 'No account was found with that email address.' }
#   end
#   erb :'sign-in'
# end
#
# get '/reset-password/?' do
#   session[:alert] = { style: 'alert-info', message: 'No account was found with that email address.' }
#   erb :'sign-in'
# end
#
# get '/new-password/:key/?' do
#   if user = User.first(pass_reset_key: params[:key], :pass_reset_date.gte => Chronic.parse('2 day ago'))
#     erb :'new-password'
#   else
#     session[:alert] = { message: 'That password reset link has expired. Start over to get a new link.', style: 'alert-info' }
#     erb :'/sign-in'
#   end
# end
#
# post '/new-password/:key/?' do
#   user = User.first(pass_reset_key: params[:key])
#   user.update(password: params[:password].downcase!)
#   session[:alert] = { message: 'You should now enter a new password and Update Account. This reset link expires after 1 day!', style: 'alert-success' }
#   sign_in user.id
# end




# get "/student/reports/:id/report/?" do
#   @school = School.all
#   @presentation = Presentation.all
#   @student = Student.get(params[:id])
#
#  if @student.class_date == nil
#    @student.class_date = @student.created_on
#    @student.save
#
#  end
#
#   erb :"/student/reports/report"
# end
#
# post "/student/reports/:id/report/?" do
#   school = School.all
#   presentation = Presentation.all
#   student = Student.get(params[:id])
#
#   unless params[:ex_score1] == params[:ex_score2]
#     student.update(
#       :ex_score1      => params[:ex_score1],
#       :ex_score2      => params[:ex_score2]
#       )
#   else
#     flash[:alert] = '1st Highest and 2nd Highest Scores cannot be the same.'
#     redirect "/student/reports/#{params[:id]}/report"
#   end
#
#    redirect "/student/reports/#{params[:id]}/ex_scores"
#
# end
#
#
#
# get "/student/reports/:id/mail_wel2/?" do
#   @school = School.all
#   @presentation = Presentation.all
#   @student = Student.get(params[:id])
#
#   erb :"/student/reports/mail_wel2"
# end



# get "/student/reports/:id/scores/?" do
#   @school = School.all
#   @exercise = Exercise.get(params[:exercise_id])
#   @student = Student.get(params[:id])
#
#   if @student.score1 && @student.score1 != ''
#
#   else
#     @student.score1 = false
#   end
#
#   if @student.score2 && @student.score2 != ''
#
#   else
#     @student.score2 = false
#   end
#
#   if @student.score3 && @student.score3 != ''
#
#   else
#     @student.score3 = false
#   end
#
#   if @student.score1 && File.exists?("./views/reports/#{@student.score1}.inc")
#     @cat1 = File.read("./views/reports/#{@student.score1}.inc")
#   end
#
#   if @student.score2 && File.exists?("./views/reports/#{@student.score2}.inc")
#     @cat2 = File.read("./views/reports/#{@student.score2}.inc")
#   end
#
#   if @student.score3 && File.exists?("./views/reports/#{@student.score3}.inc")
#     @cat3 = File.read("./views/reports/#{@student.score3}.inc")
#   end
#
#   if @student.score1 && @student.score2 && File.exists?("./views/reports/#{@student.score1}#{@student.score2}.inc")
#     @report1 = File.read("./views/reports/#{@student.score1}#{@student.score2}.inc")
#   elsif @student.score1 && @student.score2 && File.exists?("./views/reports/#{@student.score2}#{@student.score1}.inc")
#     @report1 = File.read("./views/reports/#{@student.score2}#{@student.score1}.inc")
#   end
#
#   if @student.score1 && @student.score3 && File.exists?("./views/reports/#{@student.score1}#{@student.score3}.inc")
#     @report2 = File.read("./views/reports/#{@student.score1}#{@student.score3}.inc")
#   elsif @student.score1 && @student.score3 && File.exists?("./views/reports/#{@student.score3}#{@student.score1}.inc")
#     @report2 = File.read("./views/reports/#{@student.score3}#{@student.score1}.inc")
#   end
#
#   if @student.score2 && @student.score3 && File.exists?("./views/reports/#{@student.score2}#{@student.score3}.inc")
#     @report3 = File.read("./views/reports/#{@student.score2}#{@student.score3}.inc")
#   elsif @student.score2 && @student.score3 && File.exists?("./views/reports/#{@student.score3}#{@student.score2}.inc")
#     @report3 = File.read("./views/reports/#{@student.score3}#{@student.score2}.inc")
#   end
#
#  # -------------------- show report ---------------------
#  if @student.score1 && @student.score2
#    erb :'student/reports/scores'
#  else
#    erb :'student/reports/report'
#  end
#
# end
#
# get "/student/reports/:id/ex_scores/?" do
#   @school = School.get(params[:school_id])
#   @exercise = Exercise.get(params[:exercise_id])
#   @student = Student.get(params[:id])
#
#   if @student.ex_score1 && @student.ex_score1 != ''
#
#   else
#     @student.ex_score1 = false
#   end
#
#   if @student.ex_score2 && @student.ex_score2 != ''
#
#   else
#     @student.ex_score2 = false
#   end
#
#   if @student.ex_score1 && @student.ex_score2 && File.exists?("./views/reports/#{@student.ex_score1}#{@student.ex_score2}.inc")
#     @report1 = File.read("./views/reports/#{@student.ex_score1}#{@student.ex_score2}.inc")
#   elsif @student.ex_score1 && @student.ex_score2 && File.exists?("./views/reports/#{@student.ex_score2}#{@student.ex_score1}.inc")
#     @report1 = File.read("./views/reports/#{@student.ex_score2}#{@student.ex_score1}.inc")
#   end
#
#  # -------------------- show report ---------------------
#  if @student.ex_score1 && @student.ex_score2
#    erb :'student/reports/ex_scores'
#  else
#    erb :'student/reports/report'
#  end
#
# end
#
# get "/student/reports/:id/scores_full/?" do
#   @school = School.get(params[:school_id])
#   @student = Student.get(params[:id])
#
#   if @student.score1 && @student.score1 != ''
#
#   else
#     @student.score1 = false
#   end
#
#   if @student.score2 && @student.score2 != ''
#
#   else
#     @student.score2 = false
#   end
#
#   if @student.score1 && File.exists?("./views/reports-long/#{@student.score1}.inc")
#     @cat1 = File.read("./views/reports-long/#{@student.score1}.inc")
#   end
#
#   if @student.score2 && File.exists?("./views/reports-long/#{@student.score2}.inc")
#     @cat2 = File.read("./views/reports-long/#{@student.score2}.inc")
#   end
#
#   if @student.score1 && @student.score2 && File.exists?("./views/reports-long/#{@student.score1}#{@student.score2}.inc")
#     @report1 = File.read("./views/reports-long/#{@student.score1}#{@student.score2}.inc")
#   elsif @student.score1 && @student.score2 && File.exists?("./views/reports-long/#{@student.score2}#{@student.score1}.inc")
#     @report1 = File.read("./views/reports-long/#{@student.score2}#{@student.score1}.inc")
#   end
#
#  # -------------------- show report ---------------------
#  if @student.score1 && @student.score2
#    erb :'student/reports/scores_full', layout: false
#  else
#    erb :'student/reports/report'
#  end
#
# end
#
# post "/student/reports/:id/scores_full/?" do
#   school = School.get(params[:school_id])
#   student = Student.get(params[:id])
#
#   PDFKit.configure do |config|
#     config.default_options = {
#       :print_media_type => true,
#       :page_size        => 'Letter',
#       :margin_top       => '0.25in',
#       :margin_right     => '0.25in',
#       :margin_bottom    => '0.25in',
#       :margin_left      => '0.25in'
#     }
#   end
#
#   content_type 'application/pdf'
#
#   if settings.development?
#     kit = PDFKit.new("http://localhost:4567/student/reports/#{student.id}/scores_full")
#   elsif settings.production?
#     kit = PDFKit.new("https://www.ecareerdirection.com/student/reports/#{student.id}/scores_full")
#   end
#
#   pdf = kit.to_pdf
#
# end





# get "/student/reports/:id/ex_scores_full/?" do
#   @school = School.all
#   @exercise = Exercise.get(params[:exercise_id])
#   @student = Student.get(params[:id])
#
#   if @student.ex_score1 && @student.ex_score1 != ''
#
#   else
#     @student.ex_score1 = false
#   end
#
#   if @student.ex_score2 && @student.ex_score2 != ''
#
#   else
#     @student.ex_score2 = false
#   end
#
#   if @student.ex_score1 && File.exists?("./views/reports-long/#{@student.ex_score1}.inc")
#     @cat1 = File.read("./views/reports-long/#{@student.ex_score1}.inc")
#   end
#
#   if @student.ex_score2 && File.exists?("./views/reports-long/#{@student.ex_score2}.inc")
#     @cat2 = File.read("./views/reports-long/#{@student.ex_score2}.inc")
#   end
#
#   if @student.ex_score1 && @student.ex_score2 && File.exists?("./views/reports-long/#{@student.ex_score1}#{@student.ex_score2}.inc")
#     @report1 = File.read("./views/reports-long/#{@student.ex_score1}#{@student.ex_score2}.inc")
#   elsif @student.ex_score1 && @student.ex_score2 && File.exists?("./views/reports-long/#{@student.ex_score2}#{@student.ex_score1}.inc")
#     @report1 = File.read("./views/reports-long/#{@student.ex_score2}#{@student.ex_score1}.inc")
#   end
#
#  # -------------------- show report ---------------------
#  if @student.ex_score1 && @student.ex_score2
#    erb :'student/reports/ex_scores_full', layout: false
#  else
#    erb :'student/reports/report'
#  end
#
# end
