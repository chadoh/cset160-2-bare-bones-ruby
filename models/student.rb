require "sqlite3"
require "ostruct"

class Student
  @db = SQLite3::Database.new "./db/dev.db"

  def self.all
    student_array = @db.execute("SELECT * FROM students")
    student_array.map do |id, name, email, discord|
      OpenStruct.new(:id => id, :name => name, :email => email, :discord => discord)
    end
  end
end
