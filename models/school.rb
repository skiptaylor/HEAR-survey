class School < Sequel::Model
  plugin :timestamps

  one_to_many :students
  one_to_many :presentations

  many_to_one :recruiter, required: false
  
  # before :create do |s|
  #   if s.school_password == ''
  #     zips = []
  #     passwords = School.all(zip: s.zip).map { |s| zips << s.school_password }
  #     passwords = passwords.sort{ |a, b| a <=> b }
  #     if passwords.count == 0
  #       code = '01'
  #     else
  #       code = zips.last
  #       code[0, 7] = ''
  #       code = code.to_i + 1
  #     end
  #     code = ("%02d" % code.to_i).to_s if code.to_i < 10
  #     s.school_password = "ng#{s.zip}#{code}"
  #   end
  # end
  
end


