#!/usr/bin/env bash

set -u


#Required parameters:
#  -d LONGDATETIME ($icinga.long_date_time$)
#  -l HOSTNAME ($host.name$)
#  -n HOSTDISPLAYNAME ($host.display_name$)
#  -o HOSTOUTPUT ($host.output$)
#  -r USEREMAIL ($user.email$)
#  -s HOSTSTATE ($host.state$)
#  -t NOTIFICATIONTYPE ($notification.type$)
#
#Optional parameters:
#  -4 HOSTADDRESS ($address$)
#  -6 HOSTADDRESS6 ($address6$)
#  -X HOSTNOTES ($host.notes$)
#  -b NOTIFICATIONAUTHORNAME ($notification.author$)
#  -c NOTIFICATIONCOMMENT ($notification.comment$)
#  -i ICINGAWEB2URL ($notification_icingaweb2url$, Default: unset)
#  -f MAILFROM ($notification_mailfrom$, requires GNU mailutils (Debian/Ubuntu) or mailx (RHEL/SUSE))
#  -v ($notification_sendtosyslog$, Default: false)
longdatetime=""
hostname=""
hostdisplayname=""
hostoutput=""
useremail=""
hoststate=""
notificationtype=""
hostaddress=""
hostaddress6=""
hostnotes=""
notificationauthorname=""
notificationcomment=""
icingaweb2url=""
mailfrom=""
verbose=0


OPTS=$(getopt -o d:l:n:o:r:s:t:4:6:X:b:c:i:f:v -l longdatetime:,hostname:,hostdisplayname:,hostoutput:,useremail:,hoststate:,notificationtype:,hostaddress:,hostaddress6:,hostnotes:,notificationauthorname:,notificationcomment:,icingaweb2url:,mailfrom,verbose -- "$@")
eval set -- $OPTS

while [ true ]
do
    case "$1" in
        -d|--longdatetime)
            longdatetime="$2"
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
        -o|--hostoutput)
            hostoutput="$2"
            shift 2
            ;;
        -r|--useremail)
            useremail="$2"
            shift 2
            ;;
        -s|--hoststate)
            hoststate="$2"
            shift 2
            ;;
        -t|--notificationtype)
            notificationtype="$2"
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

if [ -z "$hostname" ]
then
  echo "Parameter -l / --longdatetime is mandatory"
  exit 1
fi

if [ -z "$hostdisplayname" ]
then
  echo "Parameter -n / --hostdisplayname is mandatory"
  exit 1
fi

if [ -z "$hostoutput" ]
then
  echo "Parameter -o / --hostoutput is mandatory"
  exit 1
fi

if [ -z "$useremail" ]
then
  echo "Parameter -r / --useremail is mandatory"
  exit 1
fi

if [ -z "$hoststate" ]
then
  echo "Parameter -s / --hoststate is mandatory"
  exit 1
fi

if [ -z "$notificationtype" ]
then
  echo "Parameter -t / --notificationtype is mandatory"
  exit 1
fi

