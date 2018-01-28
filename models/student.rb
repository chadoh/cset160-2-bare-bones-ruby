require "sqlite3"
require "ostruct"

class Student
  DB = SQLite3::Database.new "./db/dev.db"

  def self.all
    student_array = DB.execute("SELECT * FROM students")
    student_array.map do |attrs|
      new(*attrs)
    end
  end

  def self.create(params)
    DB.execute(
      "INSERT INTO students (#{params.keys.join(',')}) VALUES (?, ?, ?)",
      params.values
    )
  end

  def self.find(id)
    attrs = DB.execute("SELECT * FROM students WHERE id=?", id).first
    new(*attrs)
  end

  attr_reader :id, :name, :email, :discord

  def initialize(id, name, email, discord)
    @id = id
    @name = name
    @email = email
    @discord = discord
  end

  def delete
    DB.execute(
      "DELETE FROM students WHERE id=#{id}"
    )
  end
end
