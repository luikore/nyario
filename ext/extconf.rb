require "mkmf"

def generate_version_file
  version_file = 'version.inc'
  puts "generating: #{version_file}"
  lines = File.readlines('../nyario.gemspec')
  version = nil
  lines.each do |line|
    if line =~ /s\.version =/
      version = line[/\d+(\.\d+)*(\.pre\.\d+)?/]
      break
    end
  end
  abort 'version not found' unless version
  File.open version_file, 'w' do |f|
    f.puts %Q{#define NYARIO_VERSION "#{version}"}
  end
end

def tweak_cflags
  mf_conf = RbConfig::MAKEFILE_CONFIG
  if mf_conf['CC'] =~ /gcc/
    $CFLAGS << ' -std=c99 -Wno-declaration-after-statement $(xflags)'
  end

  $CPPFLAGS << ' $(xflags)'
  puts "(to enable debug: make xflags='-DDEBUG -O0')"
end

have_kqueue = (have_header("sys/event.h") and have_header("sys/queue.h"))
have_epoll = have_func('epoll_create', 'sys/epoll.h')
abort('no kqueue nor epoll') if !have_kqueue and !have_epoll
$defs << "-DNDEBUG -D#{have_epoll ? 'HAVE_EPOLL' : 'HAVE_KQUEUE'}"

generate_version_file
tweak_cflags
create_makefile 'nyario'
