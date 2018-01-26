require "sqlite3"

db = SQLite3::Database.new "./db/dev.db"

db.execute <<-SQL
  create table students (
    name varchar(255),
    email varchar(255),
    discord varchar(255)
  );
SQL

[
  ["Chad Ostrowski", "ostrowski@stevens.edu", "ProfessorO"],
].each do |student|
  db.execute(
    "INSERT INTO students (name, email, discord) VALUES (?, ?, ?)", student
  )
end
