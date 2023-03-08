
# Creating a Web App From Scratch Using Python Flask and MySQL

## What is in this repo

* Python Flask Bucket List App following [this tutorial](https://code.tutsplus.com/series/creating-a-web-app-from-scratch-using-python-flask-and-mysql--cms-827)

* Part 1: SignUp
* Part 2: SignIn
* Part 3: Add and Display items
* Part 4: Edit and Delete items

## MySQL Setup
### install and connect to MySQL server
```
mysql.server start
mysql -u root -p
```
### create DB
```
CREATE DATABASE BucketList;
```
```
USE BucketList;
```
### create table & stored procedures
* run the following sql script
```
create_userTable.sql
sp_createUser.sql
sp_validateLogin.sql

creat_wishList.sql
sp_GetWishByUser.sql
sp_GetWishById.sql
sp_updateWish.sql
sp_addWish.sql
sp_deleteWish.sql

SHOW CREATE PROCEDURE sp_createUser;
SHOW CREATE PROCEDURE sp_validateLogin;
```