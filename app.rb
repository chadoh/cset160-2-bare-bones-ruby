require "cuba"
require "cuba/safe"
require "cuba/render"
require "erb"

require_relative "./models/student"

Cuba.use Rack::Session::Cookie, :secret => ENV["SESSION_SECRET"] || "__a_very_long_string__"

Cuba.plugin Cuba::Safe
Cuba.plugin Cuba::Render

Cuba.define do
  on root do
    students = Student.all
    res.write view("index", students: students)
  end

  on "new" do
    res.write view("new")
  end

  on post do
    on "create" do
      Student.create(
        name: req.params["name"],
        email: req.params["email"],
        discord: req.params["discord"],
      )
      res.redirect "/"
    end

    on "delete/:id" do |id|
      Student.find(id).delete
      res.redirect "/"
    end
  end

  def not_found
    res.status = "404"
    res.headers["Content-Type"] = "text/html"

    res.write view("404")
  end
end
