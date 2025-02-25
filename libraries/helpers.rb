helpers do
  
  # def sign_in recruiter_id
  #   recruiter = Recruiter.get recruiter_id
  #   session[:recruiter] = recruiter.id
  #   flash[:alert] = 'You should now enter a new password and Save Account. This reset link expires after 1 day!'
  #   redirect '/recruiters/#{recruiter.id}/profile'
  # end
  
  
  before :create do |s|
    if s.school_password == ''
      zips = []
      passwords = School.where(zip: s.zip).map { |s| zips << s.school_password }
      passwords = passwords.sort{ |a, b| a <=> b }
      if passwords.count == 0
        code = '01'
      else
        code = zips.last
        code[0, 7] = ''
        code = code.to_i + 1
      end
      code = ("%02d" % code.to_i).to_s if code.to_i < 10
      s.school_password = "ng#{s.zip}#{code}"
    end
  end
  
  def auth_recruiter
    unless session[:recruiter] || session[:admin]
      flash[:alert] = 'You do not have permission to see that page.'
      redirect '/'
    end
  end
  
  def auth_admin
    unless session[:admin]
      redirect '/'
    end
  end
  
  def active path
		path = Array[path] unless path.kind_of? Array
		match = false
		path.each {|p| match = true if request.path_info.include? p}
		'active' if match
  end
  
  
  # Formats a full date

    def format_date(date)
      date.strftime("%A %b %d, %Y")
    end


  # Formats a simple date

    def format_day(date)
      date.strftime("%b %d, %Y")
    end


  # Formats a simple date with time

    def format_day_with_time(date)
      date.strftime("%b %d, %Y at %I:%M%P")
    end


  # Formats a date for use in the US

    def format_american_day(date)
      date.strftime("%m/%d/%y")
    end


  # Converts a date into three select form elements
  # One for month, day and year
  # Each element is named after the field argument and appended with a date part
  # Example: myField_month, myField_day, myField_year

    def date_to_field(field, date)
      date_field = ""

      date_field << "<select name='#{field}_month' id='#{field}_month' class='month'>"
      (1..12).each do |m|
        date_field << "<option value='#{m}' #{'selected' if m == date.strftime('%m').to_i}>#{m}</option>"
      end
      date_field << "</select>"

      date_field << "<select name='#{field}_day' id='#{field}_day' class='day'>"
      (1..31).each do |d|
        date_field << "<option value='#{d}' #{'selected' if d == date.strftime('%d').to_i}>#{d}</option>"
      end
      date_field << "</select>"

      date_field << "<select name='#{field}_year' id='#{field}_year' class='year'>"
      (2007..Chronic.parse('3 years from now').strftime('%Y').to_i).each do |y|
        date_field << "<option value='#{y}' #{'selected' if y == date.strftime('%Y').to_i}>#{y}</option>"
      end
      date_field << "</select>"

      date_field
    end

    def date_to_field_array_hack(field, date)
      date_field = ""

      date_field << "<select name='#{field}_month]' id='#{field}_month' class='month'>"
      (1..12).each do |m|
        date_field << "<option value='#{m}' #{'selected' if m == date.strftime('%m').to_i}>#{m}</option>"
      end
      date_field << "</select>"

      date_field << "<select name='#{field}_day]' id='#{field}_day' class='day'>"
      (1..31).each do |d|
        date_field << "<option value='#{d}' #{'selected' if d == date.strftime('%d').to_i}>#{d}</option>"
      end
      date_field << "</select>"

      date_field << "<select name='#{field}_year]' id='#{field}_year' class='year'>"
      (2007..Chronic.parse('3 years from now').strftime('%Y').to_i).each do |y|
        date_field << "<option value='#{y}' #{'selected' if y == date.strftime('%Y').to_i}>#{y}</option>"
      end
      date_field << "</select>"

      date_field
    end
  
end
