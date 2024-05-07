#!/usr/bin/env bash
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function Purpose() {
# begin block comment =============================
: <<'END'

#  Purpose:   nginx basic auth

END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cd ; date ; set +vx  ; set -vx ; # echo off, then echo on
#

# Main: put code here...


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Title:  .
-----------------------2016-07-07[Jul-Thu]11-35AM


howto:

add this as shown below..

	    auth_basic "Humidex248 requires you to login";
        auth_basic_user_file /etc/apache2/.htpasswd;

_____________



# nginx conf rail256a 

upstream app1230 {
    # Path to Puma SOCK file, as defined previously
    server unix:/srv/web/rail256a/shared/sockets/puma.sock fail_timeout=0;
}

server {
    listen 1230;
    #server_name localhost;
    server_name 127.0.0.1;

    root /srv/web/rail256a/public;

    try_files $uri/index.html $uri @app1230;

    location @app1230 {
        proxy_pass http://app1230;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $http_host;
        proxy_redirect off;
	    auth_basic "Humidex248 requires you to login";
        auth_basic_user_file /etc/apache2/.htpasswd;
    }

    error_page 500 502 503 504 /500.html;
    client_max_body_size 4G;
    keepalive_timeout 10;
}


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



#
date
#
