require 'rack'

app = Proc.new do |env|
  path = env['PATH_INFO'][1..-1]
  filename = if path == ""
               "index"
             elsif File.file?("views/#{path}.html")
               path
             else
               "404"
             end
  page = File.read("views/#{filename}.html")

  [
    '200',
    {'Content-Type' => 'text/html'},
    [page]
  ]
end

Rack::Handler.default.run app, :Port => ENV['PORT'] || 5678
