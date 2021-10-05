# Apache2 with php7.2 and mariadb with phpmyadmin on Ubuntu 18.04 LTS for Development 
This is a docker image meant for modern php and mysql(mariadb) development. Don't use this image in production.

To access site contents from outside the container you should map /var/www

## How to use:
```
docker run --rm -d -p 8080:80 -p 3306:3306 -v "$PWD:/var/www/html" mrxder/docker-apache-php7.2-mysql-phpmyadmin
```

* -p 8080:80 is used to map the http port of the container to your local machine
* -p 3306:3306 is used to map the mysql port to your local machine.
* -v $PWD:/var/www/html is used to map your actual local php files to the server
* --rm is used to automatically remove the container when it exits

* phpmyadmin can be accessed by localhost:8080/phpmyadmin
* you can access the database with this user: devroot password: 123

The docker container is started with the -d flag so it will run in the background. To run commands or edit settings inside the container run `docker exec -ti /bin/bash'

## Contribute
If you find errors or want to improve this image feel free to make pull requests or open an issue.