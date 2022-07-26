# Helpers can be used anywhere in the site


  helpers do
    
    PDFKit.configure do |config|
      config.wkhtmltopdf = '/usr/bin/wkhtmltopdf'
    end


  # Inserts div#flash containing session[:flash], provided it isn't nil
  # Then nils session[:flash] so it doesn't show up on the next request
  # Useful for user notifications
  # To use it, just set session[:flash] before rendering or redirecting

      

  	# session[:alert] = {
    # 	style: 'alert-error',
    # 	heading: 'This an error',
    # 	message: 'It should be red!'
    # }
    

  # Redirects with javascript, useful for shadowboxes

    def js_redirect(url)
      '<script type="text/javascript" charset="utf-8">window.location = "' + url + '"</script>'
    end


  # Adds a class of 'active' to an element

    def active path
			path = Array[path] unless path.kind_of? Array
			match = false
			path.each {|p| match = true if request.path_info.include? p}
			'active' if match
    end


  # Used as inline html to hide elements
  # Useful alongside a conditional
  # Example: <img <%= hidden if x == y %> src="..." />

    def hidden
      'style="display: none;"'
    end


  # Formats text as Markdown

    def markdown(text)
      Kramdown::Document.new(text).to_html
    end


  # Capitalizes the first letter of each word

    def titleize(string)
      title = ''
      string.split(' ').each do |s|
        title << s.capitalize + ' '
      end
      title
    end

    # Formats phone numbers
    
    def formatted_number(number)
      unless (number == nil)
        digits = number.gsub(/\D/, '').split(//)
        
        if (digits.length == 11 and digits[0] == '1')
          # Strip leading 1
          digits.shift
        end
        
        if (digits.length == 10)
          # Rejoin for latest Ruby, remove next line if old Ruby
          digits = digits.join
          '%s-%s-%s' % [ digits[0,3], digits[3,3], digits[6,4] ]
        end
      end
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
      date.strftime("%m/%d/%Y")
    end


  # Converts a date into three select form elements
  # One for month, day and year
  # Each element is named after the field argument and appended with a date part
  # Example: myField_month, myField_day, myField_year

    def date_to_field(field, date)
      date_field = ""

      date_field << "<select name='#{field}_month' id='#{field}_month' class='month form-control pull-left'>"
      (1..12).each do |m|
        date_field << "<option value='#{m}' #{'selected' if m == date.strftime('%m').to_i}>#{m}</option>"
      end
      date_field << "</select>"

      date_field << "<select name='#{field}_day' id='#{field}_day' class='day form-control pull-left'>"
      (1..31).each do |d|
        date_field << "<option value='#{d}' #{'selected' if d == date.strftime('%d').to_i}>#{d}</option>"
      end
      date_field << "</select>"

      date_field << "<select name='#{field}_year' id='#{field}_year' class='year form-control'>"
      (1935..Chronic.parse('3 years from now').strftime('%Y').to_i).each do |y|
        date_field << "<option value='#{y}' #{'selected' if y == date.strftime('%Y').to_i}>#{y}</option>"
      end
      date_field << "</select>"

      date_field
    end

    def date_to_field_array_hack(field, date)
      date_field = ""

      date_field << "<select name='#{field}_month]' id='#{field}_month' class='month form-control'>"
      (1..12).each do |m|
        date_field << "<option value='#{m}' #{'selected' if m == date.strftime('%m').to_i}>#{m}</option>"
      end
      date_field << "</select>"

      date_field << "<select name='#{field}_day]' id='#{field}_day' class='day form-control'>"
      (1..31).each do |d|
        date_field << "<option value='#{d}' #{'selected' if d == date.strftime('%d').to_i}>#{d}</option>"
      end
      date_field << "</select>"

      date_field << "<select name='#{field}_year]' id='#{field}_year' class='year form-control'>"
      (1935..Chronic.parse('3 years from now').strftime('%Y').to_i).each do |y|
        date_field << "<option value='#{y}' #{'selected' if y == date.strftime('%Y').to_i}>#{y}</option>"
      end
      date_field << "</select>"

      date_field
    end


  end
  
