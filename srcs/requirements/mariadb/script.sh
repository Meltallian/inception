#!/bin/bash

#This command is used to initialize the MySQL data directory and 
#create the system tables that MySQL needs to function, 
#along with the root user and other MySQL system users,
#if they don't already exist.
mysql_upgrade

#This command starts the MySQL server daemon. 
#mysqld is the main program that does most of the work 
#in a MySQL installation.
mysqld