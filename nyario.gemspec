Gem::Specification.new do |s|
  s.name = "nyario"
  s.version = "0.1"
  s.author = "Zete Lui"
  s.homepage = "https://github.com/luikore/nyara"
  s.platform = Gem::Platform::RUBY
  s.summary = "Fiber-backed high performance IO lib"
  s.description = "Fiber-backed high performance IO lib"
  s.required_ruby_version = ">=2.0.0"
  s.licenses = ['BSD 3-Clause']

  s.files = Dir.glob('**/*.{rb,h,c,cc,inc}')
  s.files += Dir.glob('spec/**/*') - %w[.DS_Store]
  s.files += %w[changes copying Gemfile nyario.gemspec rakefile readme.md]
  s.files.uniq!
  s.require_paths = ["lib"]
  s.extensions = ["ext/extconf.rb"]
  s.rubygems_version = '2.0.3'
end
