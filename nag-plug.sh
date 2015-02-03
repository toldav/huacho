log=/tmp/nrpe-agent.log
# Nagios user is part of ldap account already.
# echo "user Nagios Added" >> /tmp/nagios_plugin_install.log
# Create a direcory at /tmp/nrpe to hold the Nagios plugin and Nrpe downloads; Download the Nagios Plugins
# tmp
# add Nagios User with not shell access
# useradd -s /sbin/nologin nagios
# maybe this packages: yum install gcc glibc glibc-common
# Pre-requirements: 
rpm -qa gcc openssl-devel >> $log
yum install gcc openssl-devel

echo "user Nagios Added" >> $log
mkdir /tmp/nrpe-agent ; cd /tmp/nrpe-agent
echo "/tmp/nrpe-agent direcory created " >> $log

# Download Nagios-plugin
/usr/bin/wget http://www.nagios-plugins.org/download/nagios-plugins-2.0.3.tar.gz
echo "download of plugin completed " >> $log

# Untar Nagios-plugin
/bin/tar -xvzf nagios-plugins-2.0.3.tar.gz
echo "untar of plugin completed " >> $log

# Change directory to nagios-plugins
cd nagios-plugins-2.0.3

# configure the Nagios plugin
./configure --with-nagios-user=nagios --with-nagios-group=nagios
echo "configure of plugin completed " >> $log

# run make and make install
make ; make install
echo "installation of plugin complete" >> $log

# Change the ownership of nagios path
chown -R nagios:nagios /usr/local/nagios/
echo "ownership of folders changed " >> $log

## Add heck_init_service
wget --no-check-certificate  https://raw.githubusercontent.com/jamespo/jp_nagios_checks/master/checks/check_init_service -P /usr/local/nagios/libexec
