require 'daemons'

options = {
    :app_name   => "myproc",
    :backtrace  => true,
    :monitor    => true,
    :ontop      => true
}

Daemons.run('main.rb', options)