require 'rack'

app = Proc.new do |env|
  status = '200'

  path = env['PATH_INFO'][1..-1]
  filename = if path == ""
               "index"
             elsif File.file?("views/#{path}.html")
               path
             else
               status = "404"
               "404"
             end
  page = File.read("views/#{filename}.html")

  [
    status,
    {'Content-Type' => 'text/html'},
    [page]
  ]
end

Rack::Handler.default.run app, :Port => ENV['PORT'] || 5678
