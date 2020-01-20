docker-postfix
==============

This is a fork of catatnight/postfix with integration of PostgreSQL database for dsn history of postfix logs

run postfix with smtp authentication (sasldb) in a docker container.
TLS and OpenDKIM support are optional.

## Requirement
+ Docker 1.0


## Installation
1. Build image

	```bash
	$ sudo docker pull moschini80/postfix
	```

## Usage
1. Create postfix container 

	```bash
	$ sudo docker run -p 25:25 \
			-e maildomain=mail.example.com -e smtp_user=user:pwd \
			-e dbuser=dbusername -e dbdomain=dbaddress -e  dbpassword=dbpwd -e dbname=databasename \
			--name postfix -d moschini80/postfix
	# IF database machine is container. Use: --link <name or id>:<alias{use this on dbdomain env}>
	# Set multiple user credentials: -e smtp_user=user1:pwd1,user2:pwd2,...,userN:pwdN
	```
2. Enable OpenDKIM: save your domain key ```.private``` in ```/path/to/domainkeys```

	```bash
	$ sudo docker run -p 25:25 \
			-e maildomain=mail.example.com -e smtp_user=user:pwd \
			-e dbuser=dbusername -e dbdomain=dbaddress -e  dbpassword=dbpwd -e dbname=databasename \
			-v /path/to/domainkeys:/etc/opendkim/domainkeys \
			--name postfix -d moschini80/postfix
	```
3. Enable TLS(587): save your SSL certificates ```.key``` and ```.crt``` to  ```/path/to/certs```

	```bash
	$ sudo docker run -p 587:587 \
			-e maildomain=mail.example.com -e smtp_user=user:pwd \
			-e dbuser=dbusername -e dbdomain=dbaddress -e  dbpassword=dbpwd -e dbname=databasename \
			-v /path/to/certs:/etc/postfix/certs \
			--name postfix -d moschini80/postfix
	```

## Note
+ Login credential should be set to (`username@mail.example.com`, `password`) in Smtp Client
+ You can assign the port of MTA on the host machine to one other than 25 ([postfix how-to](http://www.postfix.org/MULTI_INSTANCE_README.html))
+ Read the reference below to find out how to generate domain keys and add public key to the domain's DNS records

## Reference
+ [Postfix SASL Howto](http://www.postfix.org/SASL_README.html)
+ [How To Install and Configure DKIM with Postfix on Debian Wheezy](https://www.digitalocean.com/community/articles/how-to-install-and-configure-dkim-with-postfix-on-debian-wheezy)
+ [Understanding rsyslog pgsql integrations](https://www.rsyslog.com/doc/v8-stable/configuration/modules/ompgsql.html)
+ TBD
