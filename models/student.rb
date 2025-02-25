class Student < Sequel::Model
  plugin :timestamps

  many_to_one :school, required: false
  many_to_one :presentation, required: false
    
end