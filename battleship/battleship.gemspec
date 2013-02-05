Gem::Specification.new do |s|
	s.name = 'battleship'
	s.version = '1.0.1'
	s.date = '2012-02-01'
	s.summary = "Ruby text based version of classic board game"
	s.description = File.read(File.join(File.dirname(__FILE__), 'README'))
	s.author = "David Rodriguez"
	s.email = "davidrodriguez212@gmail.com"
	s.files = Dir["{bin,lib}/**/*"] + %w(LICENSE README)
	s.executables = ['battleship']
	s.required_ruby_version = '>=1.9'
end