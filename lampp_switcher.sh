#!/usr/bin/env bash
# script version: 1.5

LAMPP_ACTION=$1
LAMPP_VERSION=$2


LAMPP="/opt/lampp"
XAMPP=$LAMPP"/xampp"

function stopall {
    sudo $XAMPP stopapache
    sudo $XAMPP stopmysql
    sleep 3
}

function startall {
    sudo $XAMPP startapache
    sudo $XAMPP startmysql
    sleep 3
}

function stopmysql {
    sudo $XAMPP stopmysql
    sleep 3
    # this is import to make sure we are working on right databases
    # and kill any instance of mysqld on your system
    sudo killall mysqld < /dev/null &> /dev/null &
}

function stopapache {
    sudo $XAMPP stopapache
    sleep 3
    sudo killall apache2 < /dev/null &> /dev/null &
    sudo killall httpd < /dev/null &> /dev/null &
}

function startmysql {
    sudo $XAMPP startmysql
    sleep 3
}

function startapache {
    sudo $XAMPP startapache
    sleep 3
}

function checklampplink {

    # check if exist a link and delete it
    if [[ -L "$LAMPP" && -d "$LAMPP" ]]
        then
            echo "$LAMPP is a symlink to a directory: try DELETE!"
            sudo rm -f $LAMPP

            if [[ -L "$LAMPP" && -d "$LAMPP" ]];
            then
                echo "Link not deleted! exit 1"
                exit 1
            else
                echo "Link Deleted! continue ..."
            fi
        else
            echo "NO $LAMPP LINK WAS FOUND! continue ..."
    fi

    # create a new link
    echo "Try to create LAMPP link ..."
    cd /opt
    ln -s "$LAMPP$LAMPP_VERSION" "lampp"

    ## check if is created
    if [[ -L "$LAMPP" && -d "$LAMPP" ]];
        then
            echo $LAMPP "created! continue ..."
        else
            echo "LINK not created! exit 1"
            exit 1
    fi
}

function checkservices {

    echo
    $XAMPP status
    echo
    echo

    # check if services exists and try to stop property
    PIDS_MYSQL=$(ps -C mysqld -C mysqld_safe -o pid=)
    PIDS_APACHE=$(ps -C /opt/lampp/bin/ -o pid=)

    if [ -n "$PIDS_MYSQL" ];
        then
            stopmysql
        else
            echo "NO MYSQL TO KILL continue ..."
    fi
    if [ -n "$PIDS_APACHE" ];
        then
            stopapache
        else
            echo "NO APACHE TO KILL continue ..."
    fi

}



###############################################
###############################################

# get an action
if [ -z "$LAMPP_ACTION" ];
    then
        echo
        echo "ACTION: ( start | stop | restart)?"
        read LAMPP_ACTION
    else
        echo "ACTION SET TO: "$LAMPP_ACTION
fi

# if action is stop exit else verify
if [ "$LAMPP_ACTION" = "stop" ];
    then
        stopall
        exit 0
    else
     if [[ "$LAMPP_ACTION" = "start" || "$LAMPP_ACTION" = "restart" ]];
        then
            echo "Ok we will $LAMPP_ACTION continue ..."
        else
            echo "No Action .... exit 1"
            exit 1
     fi
fi

####
# get a version
if [ -z "$LAMPP_VERSION" ];
    then
        echo
        echo "VERSION: ( 5 | 7 )? "
        read LAMPP_VERSION
     else
        echo "VERSION SET TO: " $LAMPP_VERSION
fi
if [[ "$LAMPP_VERSION" = "5" || "$LAMPP_VERSION" = "7" ]];
    then
        echo "GOOD VERSION continue ..."
    else
        echo "Wrong VERSION exit 1"
        exit 1
fi

## if action is start or restart do the same
echo
echo "Checking services ..."
checkservices
echo "End check services continue ..."

# check folder link
echo
echo "Checking lampp link ..."
checklampplink
echo "End checking link continue ..."

echo

echo "Select an option to START:"
echo "1) ALL current installed services on xampp "
echo "2) to apache and mysql - phpmyadmin "
echo
echo "Type enter to start option default ( 2 ) "
read USER_START
echo
echo "Starting services ..."
echo

if [ -z "$USER_START" ];
    then
        startapache
        startmysql
     else
        if [ "$USER_START" = "1" ];
            then
                startall
            else
                startapache
                startmysql
        fi
fi

echo "Done"
exit 0
