class { 'apt':
  always_apt_update    => true,
  update_timeout       => undef,
  purge_sources_list   => true
}

class devopsworkshop::installation {
  class{ 'devopsworkshop::installation::debs': } ->
  class{ 'devopsworkshop::installation::usercreate' : } ->
  class{ 'devopsworkshop::installation::cloneworkshop': }
  class{ 'devopsworkshop::installation::packages': } ->
  class{ 'devopsworkshop::installation::archiva::installation': } ->
  class{ 'devopsworkshop::installation::archiva::usercreation': }
}

class devopsworkshop::installation::usercreate {
  user { "devops" :
    ensure     => "present",
    password   => '$1$1qJ8VElM$Rho2.94aJLFKoY7gdmJoO/',
    managehome => true
  } ->
  file { ["/home/devops/workspace"]:
    ensure => "directory",
    owner  => "devops",
    group  => "devops",
    mode   => 640,
  }
}

class devopsworkshop::installation::packages{
  package { ["wget","maven","openjdk-7-jdk"]:
    ensure => "present"
  }
}

class devopsworkshop::installation::cloneworkshop {
  vcsrepo { "/home/devops/workspace/TDDTrainingApplication":
    ensure   => present,
    provider => git,
    user     => 'devops',
    source   => "https://github.com/Hylke1982/TDDTrainingApplication.git",
    revision => "devops-experience-workshop-quick-baseline"
  }->
  file{ 'post update hook':
    path    => '/home/devops/workspace/TDDTrainingApplication/.git/hooks/post-update',
    ensure  => 'file',
    owner   => 'devops',
    group   => 'devops',
    mode    => 0744,
    content => template('/vagrant/templates/git/post-update.erb')
  }
}

class devopsworkshop::installation::debs {


  apt::source { 'deb':
    location    => 'http://nl.archive.ubuntu.com/ubuntu/',
    release     => "trusty",
    repos       => 'main restricted universe multiverse',
    include_src => true
  }
  apt::source { 'deb-updates':
    location    => 'http://nl.archive.ubuntu.com/ubuntu/',
    release     => "trusty-updates",
    repos       => 'main restricted universe multiverse',
    include_src => true
  }
  apt::source { 'deb-security':
    location    => 'http://nl.archive.ubuntu.com/ubuntu/',
    release     => "trusty-security",
    repos       => 'main',
    include_src => true
  }

}

class devopsworkshop::installation::archiva::installation{
  class{ 'archiva': }
}

class devopsworkshop::installation::archiva::usercreation{
  wait_for{ '30seconds':
    seconds => 30,
    require => Service['archiva']
  }->
  exec{ "create-admin-user" :
    command => 'curl -H "Content-Type: application/json" -X POST -d @/vagrant/files/templates/archiva/adminuser.json http://localhost:8080/restServices/redbackServices/userService/createAdminUser',
    path    => ["/usr/bin"],
  } ->
  exec{ "create-deploy-user" :
    command => 'curl -H "Authorization: Basic YWRtaW46YWRtaW4xMjM=" -H "Content-Type: application/json" -X POST -d @/vagrant/files/templates/archiva/deployuser.json http://localhost:8080/restServices/redbackServices/userService/createUser',
    path    => ["/usr/bin"]
  } ->
  exec { "assign-deployer-role-internal" :
    command => 'curl -H "Authorization: Basic YWRtaW46YWRtaW4xMjM=" http://localhost:8080/restServices/redbackServices/roleManagementService/assignRoleByName?roleName=Repository%20Manager%20-%20internal\'&\'principal=deployer',
    path    => ["/usr/bin"]
  } ->
  exec { "assign-deployer-role-snapshots" :
    command => 'curl -H "Authorization: Basic YWRtaW46YWRtaW4xMjM=" http://localhost:8080/restServices/redbackServices/roleManagementService/assignRoleByName?roleName=Repository%20Manager%20-%20snapshots\'&\'principal=deployer',
    path    => ["/usr/bin"]
  }
}

node default {
  class{ 'devopsworkshop::installation' : }
}
