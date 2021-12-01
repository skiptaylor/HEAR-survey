class Email

  def self.reset(to, password)
    body = ""
    body << "<p>Resume Tool Account</p>"
    body << "<p>Your Password: #{password}</p>"

    Pony.mail(headers: { 'Content-Type' => 'text/html' },
                   to: to,
                 from: 'no-reply@eCareerDirection.com',
              subject: 'Resume Tool Account Password',
                 body: body)
  end
  
  def self.requestcd2(school_name, school_address1, school_address2, school_city, school_state, school_zip, first_name, last_name, email, phone)

    body = ''
    body << "<h3>Request eCD Program from Educator</h3>"
    body << "<p><i>(School not yet active)</i></p>"
    body << "<p><b>School Name:</b> #{school_name}</p>"
    body << "<p>#{school_address1}</p>"
    body << "<p>#{school_address2}</p>"
    body << "<p>#{school_city} #{school_state} #{school_zip}</p>"
    body << "<p><b>Contact:</b> <b>#{first_name} #{last_name}</p>"
    body << "<p><b>Email:</b> <b>#{email}</p>"
    body << "<p><b>Phone:</b> <b>#{phone}</p>"

    Pony.mail(
      headers: { 'Content-Type' => 'text/html' },
      to: 'skip@recountant.com',
      from: 'no-reply@eCareerDirection.com',
      subject: 'Request eCD Program from Educator',
      body: body
    )
  end
  
  def self.welcome(email, first_name, last_name)

    body = ""
    body << "<p>Hello #{first_name} #{last_name}. Welcome to eCareerDirecrion</p>"
    body << "<p>Some words and full report go here!</p>"
    # body << "https://www.ecareerdirection.com/student/reports/#{student.id}/scores_full"

  Pony.mail(
    headers: { 'Content-Type' => 'text/html' },
    to: "#{email}",
    from: 'no-rely@eCareerDirection.com',
    subject: 'Welcome to eCareerDirection.',
    body: body
  )
  end
  
  # def self.studentreport
#     from = Email.new(email: 'Welcome@eCareerDirection.com')
#     to = Email.new(to: @student.email)
#     subject = 'This is your eCD full report'
#     content = Content.new(type: 'text/plain', value: 'This is your Full COG Report')
#     mail = SendGrid::Mail.new(from, subject, to, content)
#
#     mail.add_content(Content.new(type: 'text/html', value: '<html><body><h1>Welcome #{first_name}</h1><br />Here is your <b>Full COG Report.</b> <br /><br /></body></html>'))
#
#     attachment = Attachment.new
#     attachment.content = Base64.strict_encode64(File.read('http://localhost:4567/student/reports/18182/scores_full.pdf'))
#     attachment.type = 'application/pdf'
#     attachment.filename = 'COG Full Report.pdf'
#     attachment.disposition = 'attachment'
#     attachment.content_id = 'Full Report'
#     mail.add_attachment(attachment)
#
#     sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
#     response = sg.client.mail._('send').post(request_body: mail.to_json)
#     puts response.status_code
#     puts response.body
#     puts response.headers
#   end
  
end

