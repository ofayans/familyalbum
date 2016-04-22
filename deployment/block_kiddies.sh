#!/bin/bash
#
# Now just add this script in your root crontab:
# */5 * * * * <path_to_this_script>
#

RULENAME=scriptkiddies
AUDITLOG=/var/log/audit/audit.log
KIDDIES=`awk '/ssh res=failed/ {print $12}' $AUDITLOG | awk -F "=" '{print $2}' | sort`

which firewall-cmd
if [[ $? -ne 0 ]]
then
    echo "You don't seem to have firewalld installed."
    exit 1
fi

which ipset
if [[ $? -ne 0 ]]
then
    echo "You don't seem to have ipset installed. Please install it"
    exit 1
fi


ipset list $RULENAME

if [[ $? -ne 0 ]]
then
    ipset create $RULENAME hash:ip
fi

firewall-cmd --direct --get-all-rules | grep $RULENAME

if [[ $? -ne 0 ]]
then
    firewall-cmd --direct --add-rule ipv4 filter INPUT 0 -m set \
    --match-set $RULENAME src -j REJECT --reject-with icmp-port-unreachable


    firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -m set \
    --match-set $RULENAME src -j REJECT --reject-with icmp-port-unreachable

fi

banthem=""
count=0
j=""
for i in $KIDDIES
do
    if [[ $banthem == *$i* ]]
    then
        j=$i
        continue
    fi
    if [[ $i == $j ]] && [[ $count -eq 3 ]]
    then
        banthem="$banthem $i"
        count=0
    elif [[ $i == $j ]]
    then
        ((count++))
    fi
    j=$i
done

for i in $banthem
do
    ipset add $RULENAME $i
done
