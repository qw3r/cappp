class { 'apt::update': }

$required_packages = [ 'git', 'mc' ]
package { $required_packages: ensure => 'installed' }


class { 'nginx': }
nginx::resource::upstream { 'sinatra':
  ensure  => present,
  members => [
    '127.0.0.1:9292',
  ],
}
nginx::resource::vhost { 'cappp.dev':
  ensure   => present,
  proxy  => 'http://sinatra',
}


user { "cappper":
  ensure => present,
  managehome => true,
}


ssh_authorized_key { "qw3r's key":
  user => "cappper",
  ensure => present,
  type => "ssh-rsa",
  key => "AAAAB3NzaC1yc2EAAAADAQABAAABAQCvyG+xrenrxz5LqESJgEaFovO5ZIMYg1oqVTzt2WEUCsdCt8ZqrV0ZISJcITQNPf36QeQbIil7faV2RAycXRPuDDFV02EALoiUF8U1u56YXq4izK4U5v69ysXDUOvPhIFdWcqJikX0t/wqbjXvRCT7nr9LDlBRi4dBfCMwdNevSpGint8AoMhJzax7QygxzkDuI8hKiDO3SV/6q1g9HPxiKLe9QCp7r9FHx8u61wbG5hBX2XYBKBUHVv8cZWWxG6nojXyu1c6rLWYsMpe0rmaQJxksjEM/GJ/ERUNWe3I4o9EDiEd/X+pq8OsUH5a9R/Lj8vP48YsPAgxvOpU5PGdt",
}


rbenv::install { "cappper": }
rbenv::compile { "2.1.2":
  user => "cappper",
}
