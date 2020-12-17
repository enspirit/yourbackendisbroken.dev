Webspicy::Configuration.new(Path.dir) do |c|
  c.host = "http://127.0.0.1:3000"
  c.client = Webspicy::HttpClient

  c.precondition Webspicy::Specification::Pre::RobustToInvalidInput.new

  c.before_each do |tester|
    Kernel.system 'curl -X POST http://localhost:3000/reset'
  end
end
