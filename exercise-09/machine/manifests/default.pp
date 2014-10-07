class { 'apt':
  always_apt_update    => true,
  update_timeout       => undef,
  purge_sources_list   => true
}

class devopsmachine::installation {
  class { 'devopsmachine::installation::debs': } ->
  class { 'devopsmachine::installation::packages' : } ->
  class { 'devopsmachine::installation::jenkinsslave': }
}

class devopsmachine::installation::debs {

  apt::source { 'deb':
    location          => 'http://ftp.nl.debian.org/debian/',
    release           => "jessie",
    repos             => 'main',
    include_src       => true
  }

  apt::source { 'deb-updates':
    location          => 'http://ftp.nl.debian.org/debian/',
    release           => "jessie-updates",
    repos             => 'main',
    include_src       => true
  }

  apt::source { 'deb-security':
    location          => 'http://ftp.nl.debian.org/debian-security/',
    release           => "jessie/updates",
    repos             => 'main',
    include_src       => true
  }

}

class devopsmachine::installation::packages{
  package { "docker.io":
    ensure => "installed"
  } ->
  package { "maven":
    ensure => "installed"
  }

}

class devopsmachine::installation::jenkinsslave{
  class { 'jenkins::slave':
    slave_name => "docker-slave",
    labels     => "docker",
    masterurl  => 'http://33.33.33.30:8080'
  }
}

node default{

  class { 'devopsmachine::installation': }

}