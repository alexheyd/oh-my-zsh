addvhost() {
    SITES_FOLDER="/Users/alexheyd/Sites"

    echo -e "Host name (e.g dev.domain.com):"
    read hostname

    echo -e "Document root (directory located in ~/Sites):"
    read docroot

    FULL_PATH="$SITES_FOLDER/$docroot"

    if [ ! -d "$FULL_PATH" ]; then
        mkdir $FULL_PATH
    fi

    # add host entry
    echo "\n127.0.0.1 $hostname" | sudo tee -a /etc/hosts

    # add vhost entry
    echo "\n
        <VirtualHost *:80>
            ServerName $hostname
            DocumentRoot $FULL_PATH
        </VirtualHost>" | sudo tee -a /etc/apache2/extra/httpd-vhosts.conf

    # set correct permissions
    sudo chmod 755 $docroot

    # restart apache
    sudo apachectl restart

    echo "VirtualHost successfully added for $hostname."
}