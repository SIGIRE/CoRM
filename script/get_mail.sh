#!/bin/bash

# This script checks new emails from the get_mails function
cd /webapps/crm/current
/usr/local/bin/rake /webapps/crm/current/ mail:get_mails RAILS_ENV=production
exit
