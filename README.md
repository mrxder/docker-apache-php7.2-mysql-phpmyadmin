# Apache2 with php7.2 and mariadb with phpmyadmin on Ubuntu 18.04 LTS for Development 
This is a docker image meant for modern php and mysql(mariadb) development. Don't use this image in production.

To access site contents from utside the container you should map /var/www

## How to use:
`docker run -d -p 8080:80 -d 3306:3306 -v /home/user/html:/var/www/html todo`
* -p 8080:80 is used to map the http port of the container to your local machine
* -p 3306:3306 is used to map the mysql port to your local machine.
* -v /home/u...:/var/www/html is used to map your local php files to the server

* phpmyadmin can be accessed by localhost:8080/phpmyadmin
* you can access the database with this user: devroot password: 123

The docker container is started with the -d flag so it will run in the background. To run commands or edit settings inside the container run `docker exec -ti /bin/bash'