#!/bin/bash

  #Assignment 11 April : user management 

#This will check if  empty string before assignment
UserName=$1
Action=$2
Password=$3

if [[ -z "$UserName" || -z "$Action" ]]; then
 echo "Usage : $0  <UserName> <Add/Update/Delete> [Password] "
exit 1 
fi

# This will check  that incase of Update and  add we need password  
if  [[ "$Action" == "add" ||  "$Action" == "update" ]];  then
   if  [[ -z "$Password" ]]; then
    echo  " Password  is needed for $Action"
    exit  1
  fi 
fi

#This will check  if we are using  correct  action for user   management 
if [[ "$Action" != "add"  &&  "$Action" != "update" &&  "$Action" != "delete" ]]; then
      echo "Invalid action , use  add , update or  delete."
     exit
fi

#Check for  if user already in system or not 
   id "$UserName" &>/dev/null
   rc=$?


# This will perform the action 
if  [[ $Action == "add" ]]; then
 
  if  [[ $rc -eq 0 ]] ; then
   echo " User $UserName already exists"
   echo "please choose different name for user"
   exit 1
  fi 
      sudo  useradd   -m -s /bin/bash $UserName
      sudo  chpasswd 
      echo "$UserName :$Password" 
      echo  " User $UserName  added Successfully. " 
      exit 0
     
elif  [[ $Action  == "update"   &&  -n $Password  ]]; then
 
    if  [[ $rc -eq 0 ]] ; then
    sudo   usermod -p  $Password  $UserName
    echo  "User $UserName  password   updated "
    exit 0
    fi

     echo  "Please create a user  $UserName in system"
     exit 1
  
elif [[ $Action == "delete" ]]; then 

     if  [[ $rc -eq 0 ]] ; then
     sudo  userdel -r  $UserName
    echo  "User $UserName is Deleted"
    exit 0
    fi

      echo "No such user found  with Name   $UserName"
    exit 1
fi

