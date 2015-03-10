#!/bin/sh

# Required GEM version for librarian puppet
REQUIRED_GEM_VERSION=1.9
PUPPET_DIR=/etc/puppet/

# Set correct package manager
set_package_manager()
{
 # Determine which package manager to use
 $(which apt-get > /dev/null 2>&1)
 FOUND_APT=$?
 
 $(which yum > /dev/null 2>&1)
 FOUND_YUM=$?
 
 if [ "${FOUND_YUM}" -eq '0' ]; then
  echo "Package manager is YUM"
  PACKAGER_UPDATE="yum -q -y makecache"
  PACKAGER_INSTALL="yum -q -y install "
 elif [ "${FOUND_APT}" -eq '0' ]; then
  echo "Package manager is APT"
  PACKAGER_UPDATE="apt-get -q -y update"
  PACKAGER_INSTALL="apt-get -q -y install "
 else
  echo 'No package installer available'
 fi
 
}

install_debian_keyring()
{
 # Install these packages to use debian/ubuntu security updates
 if [ "${FOUND_APT}" -eq '0' ]; then
  $PACKAGER_INSTALL debian-keyring debian-archive-keyring
 fi
}

# Install GIT if needed
install_git()
{
 $(which git > /dev/null 2>&1)
 local FOUND_GIT=$?
 
 if [ "$FOUND_GIT" -ne '0' ]; then
  echo "Starting to install GIT"
  $PACKAGER_UPDATE
  $PACKAGER_INSTALL git
 else
  echo "GIT was found no GIT installation required"
 fi
}


# Install gem if needed or if version is incorrect
install_gem()
{
 $(which gem > /dev/null 2>&1)
 local FOUND_GEM=$?
 echo "Install gem" 

 # Check if gem version is correct
 check_gem_version()
 {
  local GEM_VERSION=$(gem --version)
  local GEM_VERSION_MAJOR=$(echo $GEM_VERSION | awk -F \. {'print $1'})
  local GEM_VERSION_MINOR=$(echo $GEM_VERSION | awk -F \. {'print $2'})
  local REQUIRED_GEM_VERSION_MAJOR=$(echo $REQUIRED_GEM_VERSION | awk -F \. {'print $1'})
  local REQUIRED_GEM_VERSION_MINOR=$(echo $REQUIRED_GEM_VERSION | awk -F \. {'print $2'})
  
  local return_val=false
  if [ "$REQUIRED_GEM_VERSION_MAJOR" -le "$GEM_VERSION_MAJOR" ]; then
   if [ "$REQUIRED_GEM_VERSION_MINOR" -le "$GEM_VERSION_MINOR" ]; then
    local return_val=true
   fi
  fi
  echo "$return_val"
 }

 if [ "$FOUND_GEM" -ne '0' ]; then
  echo "GEM not found"
  $PACKAGER_INSTALL ruby2.0
 else
  local GEM_VERSION_OK=$(check_gem_version)
  if [ "$GEM_VERSION_OK" != 'true' ]; then
   $PACKAGER_INSTALL ruby1.9.3
  else
   echo "Correct GEM version installed"
  fi
 fi
 echo "End install gem"

}

# Create puppet dir if needed and copy files
create_puppet_dir()
{
 if [ ! -d "$PUPPET_DIR" ]; then
  mkdir -p $PUPPET_DIR
 fi
 cp /vagrant/puppet/Puppetfile $PUPPET_DIR
}

# Install librarian puppet
install_librarian_puppet()
{
 if [ "$(gem list -i '^librarian-puppet$')" = "false" ]; then
  gem install librarian-puppet
  cd $PUPPET_DIR && librarian-puppet install --clean
 else
  cd $PUPPET_DIR && librarian-puppet update
 fi
}

echo "Start preparation for librarian-puppet"
set_package_manager
install_debian_keyring
install_git
install_gem
create_puppet_dir
install_librarian_puppet
echo "Finished installation librarian puppet"