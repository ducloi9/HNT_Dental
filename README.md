# HNT Dental 

## Web Application for HNT Dental

## Development Environment
### Install JDK 17 and MySQL 8.0
* Download JDK 17 from [Oracle](https://download.oracle.com/java/17/archive/jdk-17.0.6_windows-x64_bin.exe)
* Download MySQL 8.0 from [MySQL](https://dev.mysql.com/downloads/windows/installer/8.0.html)
* Best recommend to use [IntelliJ IDEA Ultimate](https://www.jetbrains.com/idea/download/#section=windows) to run this project.
### Database
* Create a schema in database
  `CREATE DATABASE 'hnt_dental' CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;`
* If run project have error about import data, try drop schema and create again. (because this project using flyway to migrate database)

### Create environment file
* Create a file named `.env` in the anywhere you want.
* Copy the contents of `.env.example` into the new file and fill in the values.
* Install EnvFile plugin
* Enable EnvFile configuration then select `.env` file

### Run application.
* Run `Application.java`
* If error occurs, try to configure `.env` file again.

## Production Environment
wait for update next time.

>    It's better to use IntelliJ IDEA Ultimate to run this project.

## Happy coding!
