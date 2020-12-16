Webspicy::Configuration.new(Path.dir) do |c|
  c.host = "http://127.0.0.1:3000"
  c.client = Webspicy::HttpClient
end
