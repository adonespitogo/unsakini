###UNSAKINI


**Unsakini** ("what is this") in Cebuano language is a web app that encrypts data in the client-side and sends encrypted data to the server. This way, only you can access your data so it stays safe from everyone else, even when the server gets compromised.

The source code is opensourced so you can review it and deploy it on your own server. Anyhow, you can always make use of the deployed app at [www.unsakini.com](https://www.unsakini.com).


### Getting Started

 - npm install -g gulp sequelize sequelize-cli typescript typings coffee-script angular-cli
 - npm install

**Note:** Make sure to create a dev database setup (mysql) with db name `unsakini`, `username=root` and `password=null` in your localhost.

### Frontend development
Run with live reload, but without api
```
$ng serve
```
Angular CLI will open a window with live reload.


### Run the api server
```
$ node index.js
```
 - Browse to [http://localhost:3000](http://localhost:3000)

### Build the angular app
```
$ ng build
```
