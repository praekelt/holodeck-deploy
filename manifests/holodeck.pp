# Globally set exec paths and user.
Exec {
    path => ["/bin", "/usr/bin", "/usr/local/bin"],
    user => 'ubuntu',
}

# Install required packages.
package { [
    "git-core",
    "libpq-dev",
    "postgresql",
    "python-dev",
    "python-pip",
    "python-virtualenv",
    "supervisor",
    "nginx",
    ]:
    ensure => installed,
}

# Ensure Ubuntu user exists
user { "ubuntu":
    ensure => "present",
    home => "/home/ubuntu",
    shell => "/bin/bash"
}

# Create the deployment directory
file { "/var/praekelt/":
    ensure => "directory",
    owner => "ubuntu",
    subscribe => User["ubuntu"]
}

# Clone and update repo.
exec { "clone_repo":
    command => "git clone https://github.com/praekelt/holodeck-deploy.git holodeck",
    cwd => "/var/praekelt",
    unless => "test -d /var/praekelt/holodeck",
    subscribe => [
        Package['git-core'],
        File['/var/praekelt/'],
    ]
}

exec { "update_repo":
    command => "git pull origin",
    cwd => "/var/praekelt/holodeck",
    subscribe => [
        Exec['clone_repo'],
    ]
}

# Create virtualenv and install packages.
exec { 'create_virtualenv':
    command => 'virtualenv --no-site-packages ve',
    cwd => '/var/praekelt/holodeck',
    unless => 'test -d /var/praekelt/holodeck/ve',
    subscribe => [
        Package['libpq-dev'],
        Package['python-dev'],
        Package['python-virtualenv'],
        Exec['clone_repo'],
    ]
}

exec { 'install_packages':
    command => '/bin/sh -c ". ve/bin/activate && pip install -r requirements.pip && deactivate"',
    cwd => '/var/praekelt/holodeck',
    subscribe => [
        Exec['create_virtualenv'],
        Exec['update_repo'],
    ]
}

# Manage Nginx symlinks.
file { "/etc/nginx/sites-enabled/holodeck.conf":
    ensure => symlink,
    target => "/var/praekelt/holodeck/nginx/holodeck.conf",
    require => [
        Exec['update_repo'],
        Package['nginx'],
    ]
}

file { "/etc/nginx/sites-enabled/default":
    ensure => absent,
    subscribe => [
        Package['nginx'],
    ]
}

# Manage supervisord symlinks.
file { "/etc/supervisor/conf.d/holodeck.conf":
    ensure => symlink,
    target => "/var/praekelt/holodeck/supervisord/holodeck.conf",
    subscribe => [
        Exec['update_repo'],
        Package['supervisor']
    ]
}

# Create Postgres role and database.
postgres::role { "holodeck":
    password => holodeck,
    ensure => present,
    subscribe => Package["postgresql"],
}

postgres::database { "holodeck":
    owner => holodeck,
    ensure => present,
    template => "template0",
}
