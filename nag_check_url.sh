#!/bin/ksh
#
APP="URL_ERROR"
LINE=$APP
export $APP
ok=3

HOST=`/bin/hostname`

#
# check Port 8071
#
url_stat=`/u02/scripts/psoft/check_sisportal_url.pl $HOST 8071 /csprod-adm/images/bb.htm | awk '{print $5}'`

if [ $url_stat = "green" ]; then
   flag=pass
   #
   # check Port 8072
   #
   url_stat=`/u02/scripts/psoft/check_sisportal_url.pl $HOST 8072 /csprod-adm/images/bb.htm | awk '{print $5}'`
   if [ $url_stat = "green" ]; then
      flag=pass
   else
      flag=fail
      error_port=8072
   fi

else
   flag=fail
   error_port=8071
fi


if [ $flag = "pass" ]
then
        COLOR="green"
        LINE=$APP" is up and active."
        echo $LINE
        ok=0
else
        COLOR="red"
        LINE="$APP Port $error_port Failed.  Please call DBA on call immediately"
        echo $LINE
        ok=2
fi

exit $ok
