#!/usr/bin/env bash

set -u


#Required parameters:
#  -d LONGDATETIME ($icinga.long_date_time$)
#  -e SERVICENAME ($service.name$)
#  -l HOSTNAME ($host.name$)
#  -n HOSTDISPLAYNAME ($host.display_name$)
#  -o SERVICEOUTPUT ($service.output$)
#  -r USEREMAIL ($user.email$)
#  -s SERVICESTATE ($service.state$)
#  -t NOTIFICATIONTYPE ($notification.type$)
#  -u SERVICEDISPLAYNAME ($service.display_name$)
#
#Optional parameters:
#  -4 HOSTADDRESS ($address$)
#  -6 HOSTADDRESS6 ($address6$)
#  -X HOSTNOTES ($host.notes$)
#  -x SERVICENOTES ($service.notes$)
#  -b NOTIFICATIONAUTHORNAME ($notification.author$)
#  -c NOTIFICATIONCOMMENT ($notification.comment$)
#  -i ICINGAWEB2URL ($notification_icingaweb2url$, Default: unset)
#  -f MAILFROM ($notification_mailfrom$, requires GNU mailutils (Debian/Ubuntu) or mailx (RHEL/SUSE))
#  -v ($notification_sendtosyslog$, Default: false)
longdatetime=""
servicename=""
hostname=""
hostdisplayname=""
serviceoutput=""
useremail=""
servicestate=""
notificationtype=""
servicedisplayname=""
hostaddress=""
hostaddress6=""
hostnotes=""
servicenotes=""
notificationauthorname=""
notificationcomment=""
icingaweb2url=""
mailfrom=""
verbose=0


OPTS=$(getopt -o d:e:l:n:o:r:s:t:u:4:6:X:x:b:c:i:f:v -l longdatetime:,servicename:,hostname:,hostdisplayname:,serviceoutput:,useremail:,servicestate:,notificationtype:,servicedisplayname:,hostaddress:,hostaddress6:,hostnotes:,servicenotes:,notificationauthorname:,notificationcomment:,icingaweb2url:,mailfrom,verbose -- "$@")
eval set -- $OPTS

while [ true ]
do
    case "$1" in
        -d|--longdatetime)
            longdatetime="$2"
            shift 2
            ;;
        -e|--servicename)
            servicename="$2"
            shift 2
            ;;
        -l|--hostname)
            hostname="$2"
            shift 2
            ;;
        -n|--hostdisplayname)
            hostdisplayname="$2"
            shift 2
            ;;
        -o|--serviceoutput)
            serviceoutput="$2"
            shift 2
            ;;
        -r|--useremail)
            useremail="$2"
            shift 2
            ;;
        -s|--servicestate)
            servicestate="$2"
            shift 2
            ;;
        -t|--notificationtype)
            notificationtype="$2"
            shift 2
            ;;
        -u|--servicedisplayname)
            servicedisplayname="$2"
            shift 2
            ;;
        -4|--hostaddress)
            hostaddress="$2"
            shift 2
            ;;
        -6|--hostaddress6)
            hostaddress6="$2"
            shift 2
            ;;
        -X|--hostnotes)
            hostnotes="$2"
            shift 2
            ;;
        -x|--servicenotes)
            servicenotes="$2"
            shift 2
            ;;
        -b|--notificationauthorname)
            notificationauthorname="$2"
            shift 2
            ;;
        -c|--notificationcomment)
            notificationcomment="$2"
            shift 2
            ;;
        -o|--icingaweb2url)
            icingaweb2url="$2"
            shift 2
            ;;
        -f|--mailfrom)
            mailfrom="$2"
            shift 2
            ;;
        -v|--verbose)
            verbose=1
            shift
            ;;
        -h|--help)
            say_help
            shift
            exit 0
            ;;
        --)
            shift
            break
            ;;
        *)
            echo "Option '$1' is not recognized"
            exit 1
            ;;
    esac
done

if [ -z "$longdatetime" ]
then
  echo "Parameter -d / --longdatetime is mandatory"
  exit 1
fi

if [ -z "$servicename" ]
then
  echo "Parameter -e / --servicename is mandatory"
  exit 1
fi

if [ -z "$hostname" ]
then
  echo "Parameter -l / --hostname is mandatory"
  exit 1
fi

if [ -z "$hostdisplayname" ]
then
  echo "Parameter -n / --hostdisplayname is mandatory"
  exit 1
fi

if [ -z "$serviceoutput" ]
then
  echo "Parameter -o / --serviceoutput is mandatory"
  exit 1
fi

if [ -z "$useremail" ]
then
  echo "Parameter -r / --useremail is mandatory"
  exit 1
fi

if [ -z "$servicestate" ]
then
  echo "Parameter -s / --servicestate is mandatory"
  exit 1
fi

if [ -z "$notificationtype" ]
then
  echo "Parameter -t / --notificationtype is mandatory"
  exit 1
fi

if [ -z "$servicedisplayname" ]
then
  echo "Parameter -u / --servicedisplayname is mandatory"
  exit 1
fi
