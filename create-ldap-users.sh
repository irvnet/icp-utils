#!/bin/bash

count=1
PREFIX="user"
FNAME=""
USERFILES="ldif-users"
USERGROUPDEF="user-group-def.ldif"
USERNAME=""
OU="users"
line=""

# make a place to stash ldif files
mkdir $USERFILES

# create group definition file for the "user" group
touch $USERFILES/$USERGROUPDEF
echo "dn: cn=users,ou=groups,dc=mycluster,dc=icp" >> $USERFILES/$USERGROUPDEF
echo "cn: users" >> $USERFILES/$USERGROUPDEF
echo "objectclass: groupOfUniqueNames" >> $USERFILES/$USERGROUPDEF
echo "objectclass: top" >> $USERFILES/$USERGROUPDEF



# go make use ldif files
while [ $count -lt 60 ]
do
  USERNAME=user$(printf %02d $count)
  echo "new user: $USERNAME"

  FNAME=$USERNAME.ldif
  echo "new ldif: $FNAME"

  if [ ! -d $USERFILES/$FNAME ]; then

    # create user ldif 
    touch ./$USERFILES/$FNAME
    echo "created $FNAME"

    # update ldif  
    line="dn: uid=$USERNAME,ou=$OU,dc=mycluster,dc=icp"
    echo $line > $USERFILES/$FNAME

    line="cn: $USERNAME"
    echo $line                               >> $USERFILES/$FNAME

    echo "objectclass: inetOrgPerson"        >> $USERFILES/$FNAME
    echo "objectclass: organizationalPerson" >> $USERFILES/$FNAME
    echo "objectclass: person"               >> $USERFILES/$FNAME
    echo "objectclass: top"                  >> $USERFILES/$FNAME
    echo "sn: $USERNAME"                     >> $USERFILES/$FNAME

    line="uid: $USERNAME"
    echo $line                               >> $USERFILES/$FNAME  

    # add the password "passw0rd" for each user
    echo "userpassword: {MD5}vtEoNlIWwBmYiRXtOt11+w==" >> $USERFILES/$FNAME

    # add the user details to the "users" group
    line="uniquemember: uid=$USERNAME,ou=users,dc=mycluster,dc=icp"
    echo $line >> $USERFILES/$USERGROUPDEF

  fi

  count=`expr $count + 1`
done

