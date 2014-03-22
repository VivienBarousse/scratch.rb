spec = Gem::Specification.new do |s|
  s.name            = "scratch.rb"
  s.version         = "0.0.1"
  s.summary         = "Ruby implementation of the Scratch API"
  s.author          = "Vivien Barousse"
  s.email           = "barousse.vivien@gmail.com"
  s.homepage        = "https://github.com/VivienBarousse/scratch.rb"
  
  s.files           = Dir.glob("lib/**/*")
  s.require_paths   = ["lib"]

  s.add_dependency  "gosu", "~> 0.7.50"

  s.add_development_dependency "rake",  "~> 10.1.0"
  s.add_development_dependency "rspec", "~> 2.14.1"
end
