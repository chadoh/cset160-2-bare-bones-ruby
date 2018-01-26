require "cuba"
require "cuba/safe"
require "cuba/render"
require "erb"

Cuba.use Rack::Session::Cookie, :secret => ENV["SESSION_SECRET"] || "__a_very_long_string__"

Cuba.plugin Cuba::Safe
Cuba.plugin Cuba::Render

Cuba.define do
  on "about" do
    res.write view("about")
  end

  on root do
    res.write view("index")
  end

  def not_found
    super
    res.write view("404")
  end
end
