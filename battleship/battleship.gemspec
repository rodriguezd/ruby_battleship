Gem::Specification.new do |s|
	s.name = 'battleship'
	s.version = '1.1.2'
	s.date = '2012-03-20'
	s.summary = "Ruby text-based version of the classic board game"
	s.description = "Ruby text-based version of the classic board game"
	s.author = "David Rodriguez"
	s.email = "davidrodriguez212@gmail.com"
	s.homepage = "https://github.com/rodriguezd/ruby_battleship"
	s.files = Dir["{bin,lib}/**/*"] + %w(LICENSE.md README.md)
	s.executables = ['battleship']
	s.required_ruby_version = '>=1.9'
	s.add_runtime_dependency 'colorize', '>= 0.5.8'
end