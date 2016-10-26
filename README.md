###UNSAKINI


**Unsakini** ("what is this") in Cebuano language is a web app that encrypts data in the client-side and sends encrypted data to the server. This way, only you can access your data so it stays safe from everyone else, even when the server gets compromised.

The source code is opensourced so you can review it and deploy it on your own server. Anyhow, you can always make use of the deployed app at [www.unsakini.com](https://www.unsakini.com).

### Planned Features
- [x] Encrypt data
- [ ] Upload and encrypt files
- [ ] Share encrypted data and files to other users

-------------------------
### Getting Started
```
$ npm install -g gulp sequelize sequelize-cli typescript typings coffee-script angular-cli
$ npm install
```

**Note:** Make sure to create a dev database setup (mysql) with db name `unsakini`, `username=root` and `password=null` in your localhost.

### Development

Run server
```
$ node index.js
```
Build the Angular2 app
```
$ ng build
```
Browse to [http://localhost:3000](http://localhost:3000)


Angular app sources are under the `./src/app` directory, while the api sources are under the `./api` directory.
