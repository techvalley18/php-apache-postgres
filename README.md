PHP 7.2 Apache Stretch

This is my own development image for Netpunkt.dk and Bibliotek.dk.

Contains:
 - Xdebug
 - Memcache
 - GD
 - PDO_pgsql
 - Yaml
 - Opcache 
 - Soap

Commands needed:
   docker build -t lapp7 .
   
   docker create -p 80:80 -v /home/username/WebSites/netpunkt-featurebranch:/var/www/html --name netpunkt-featurebranch --hostname np-fb --link postgrescontainer lapp7
   
   docker start netpunkt-featurebranch
   
The lapp7 is my naming convension for LinuxApachePostgresPHP7.

The -p is the port number and -v is the volume where the code is. --link is another container that contains the postgresDB.
