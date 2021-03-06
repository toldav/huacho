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
#yum install gcc openssl-devel

## check IF dsmc 2.5 or 2.6 for tsm to work
uname -a >> $log

## tsm_client or release 5 & 6
cat /etc/*release >> $log

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

## Add check_init_service
#wget --no-check-certificate  https://raw.githubusercontent.com/jamespo/jp_nagios_checks/master/checks/check_init_service -P /usr/local/nagios/libexec

## Add CPU perf
wget --no-check-certificate https://raw.githubusercontent.com/skywalka/check-cpu-perf/master/check_cpu_perf.sh -P /usr/local/nagios/libexec
mv /usr/local/nagios/libexec/check_cpu_perf.sh /usr/local/nagios/libexec/check_cpu_perf
chmod +x /usr/local/nagios/libexec/check_cpu_perf
chown nagios.nagios /usr/local/nagios/libexec/check_cpu_perf
echo "Added check_cpu_perf.sh" >> $log

## Add check_sar_perf.py
wget --no-check-certificate https://raw.githubusercontent.com/nickanderson/check-sar-perf/master/check_sar_perf.py -P /usr/local/nagios/libexec
chmod +x /usr/local/nagios/libexec/check_sar_perf.py
chown nagios.nagios /usr/local/nagios/libexec/check_sar_perf.py
echo "Added check_sar_perf.py" >> $log

# Add check_exit_status.pl
wget --no-check-certificate https://raw.githubusercontent.com/toldav/huacho/master/check_exit_status.pl -P /usr/local/nagios/libexec
chmod +x /usr/local/nagios/libexec/check_exit_status.pl
chown nagios.nagios /usr/local/nagios/libexec/check_exit_status.pl
echo "Added check_exit_status.pl" >> $log

# Over write check_tsm_client new Version by MK
/bin/cp -p /usr/local/nagios/libexec/check_tsm_client /usr/local/nagios/libexec/check_tsm_client.bak
#wget --no-check-certificate https://raw.githubusercontent.com/toldav/huacho/master/check_tsm_client -O /usr/local/nagios/libexec/check_tsm_client
wget --no-check-certificate https://raw.githubusercontent.com/toldav/huacho/master/check_tsm_client_v5_v6 -O /usr/local/nagios/libexec/check_tsm_client
chmod +x /usr/local/nagios/libexec/check_tsm_client
chown nagios.nagios /usr/local/nagios/libexec/check_tsm_client
echo "Over write check_tsm_client" >> $log


#wget  --no-check-certificate https://raw.githubusercontent.com/toldav/huacho/master/nag-plug.sh; chmod +x /tmp/nag-plug.sh
