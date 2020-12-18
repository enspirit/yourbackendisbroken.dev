Webspicy::Configuration.new(Path.dir) do |c|
  c.host = "http://127.0.0.1:3000"
  c.client = Webspicy::HttpClient

  c.before_each do
    Kernel.system 'curl -X POST http://localhost:3000/reset'
  end

  c.precondition Webspicy::Specification::Precondition::RobustToInvalidInput.new
end
