
# HairSalon Admin

#### _A web admin application that allows a Hair Salon owner to manage their stylists and clients.

#### By _**Diego Suarez**_

## Description

_The administrator can create new clients or stylists, assign stylists to clients and edit any of their informations._

## Setup/Installation Requirements

* _In the command line, run:_
```
$ postgres
$ psql
CREATE DATABASE hair_salon;

\c hair_salon;

CREATE TABLE stylists (id serial PRIMARY KEY, name varchar, specialty varchar, title varchar, image varchar, bio text);

CREATE TABLE clients (id serial PRIMARY KEY, name varchar, next_appointment timestamp, stylist_id int);

CREATE DATABASE hair_salon_test WITH TEMPLATE hair_salon;
```
* _Then, in another window:_
```
$ git clone https://github.com/DiegoSPB/hair_salon_admin_ruby
$ cd hair_salon_admin_ruby
$ bundle
$ ruby app.rb
```
* _Then, in any a browser:_

```
localhost:4567
````


*Be sure to change DB = PG.connect({:dbname => 'hair_salon'}) to DB = PG.connect({:dbname => 'hair_salon_test'}) if trying out the integration specs

## Support and contact details

_Contact me at: diego.spb@gmail.com

## Technologies Used

_Ruby, Sinatra, PostgreSQL, HTML, Bootstrap_

### License

*MIT*

Copyright (c) 2016 **Diego Suarez**
