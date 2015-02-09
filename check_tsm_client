#!/bin/ksh
#
# Kron shell script to check if TSM client is running and working..
# if the date on the last line in dsmsched.log is more then 1 day the TSM client is not working.
#
# MC rev 1.0 11/18/13
#
app="TSM Client:"
PROGPATH=$(echo $0 | sed -e 's,[\\/][^\\/][^\\/]*$,,')
. ${PROGPATH}/utils.sh

LOG=/var/tsm/dsmsched.log

line=$(ps -ef |grep "dsmc sched" | grep -v grep | wc -l)
if [[ ${line} -eq 0 ]]
then
        print "${app} CRITICAL down"
        exit ${STATE_CRITICAL}
else
        if [[ -r $LOG ]]
        then
                dates="$(date +%m/%d/%Y) $(date +%m/%d/%y) $(date +%D --date='1 day ago') $(date +%m/%d/%Y --date='1 day ago')"
                DATE=`tail -n 1 $LOG | awk '{print $1}'`
                if echo ${dates} | grep -q "${DATE}"
                then
                        print "${app} OK"
                        exit ${STATE_OK}

                else
                        print "${app} CRITICAL. Last TSM log date:${date}"
                        exit ${STATE_CRITICAL}
                fi
        else
                print "${app} WARNING, dsmc is running but can't read dsmsched.log"
                exit ${STATE_WARNING}
        fi
fi
