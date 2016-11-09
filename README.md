UNSAKINI
-----------

**Unsakini** ("what is this") in Cebuano language is a web app that encrypts data in the client-side and sends encrypted data to the server. This way, only you can access your data so it stays safe from everyone else, even when the server gets compromised.

The source code is opensourced so you can review it and deploy it on your own server. Anyhow, you can always make use of the deployed app at [www.unsakini.com](https://www.unsakini.com).

### Planned Features
- [x] Encrypt data
- [ ] Upload and encrypt files
- [ ] Share encrypted data and files to other users

-------------------------
### Getting Started
Configure your local development environment first. Rename the `config/development/*.json.sample` to `config/development/*.json` and modify accordingly.

There are four configuration files for each environment namely:
 - `application.json` - Configuration for the application like base url
 - `database.json` - Database configuration
 - `express-mail.json` - Configuration for the [express-mail](https://github.com/sorich87/express-mail) plugin
 - `security.json` - Configuration for the server AES passphrase, AES Inivialization Vector (IV) and Json Web Token (JWT) secret

You can also use environment variables in the configuration files. Instead of passing a string as a value, pass an object with a key `use_env_variable`. Ex:

config/production/application.json
```json
{
  "base_url": {
    "use_env_variable": "BASE_URL"
  }
}
```

Instead of:
```json
{
  "base_url": "https://www.unsakini.com"
}
```

The production configuration already uses environment variables namely:

- `DATABASE_URL` - In the form of `mysql://db_username:db_password@example.com/database_name`
- `JWT_SECRET` - jwt secret for issuing authentication token
- `MAILER_FROM` - [express-mail](https://github.com/sorich87/express-mail) `from` option (ex: pitogo.adones@gmail.com)
- `MAILER_HOST` - [express-mail](https://github.com/sorich87/express-mail) `host` option (ex: smtp.gmail.com)
- `MAILER_SECURE_CONNECTION` - [express-mail](https://github.com/sorich87/express-mail) `secureConnection` (boolean)
- `MAILER_PORT` - [express-mail](https://github.com/sorich87/express-mail) `port` option (ex: 465)
- `MAILER_USER` - [express-mail](https://github.com/sorich87/express-mail) `auth.user` option (ex: pitogo.adones@gmail.com)
- `MAILER_PASS` - [express-mail](https://github.com/sorich87/express-mail) `auth.pass` option (password)
- `CRYPTO_PASSPHRASE` - Passphrase used for encrypting the data in the server-side (string)
- `CRYPTO_IV` - Initializatoin Vector used for encrypting the data in the server-side (string)

Then install the needed packages:
```
$ npm install -g gulp sequelize sequelize-cli typescript typings coffee-script angular-cli mysql
$ npm install
```

Build the Angular2 app
```
$ ng build
```

Run the express server
```
$ npm start
```
Browse to [http://localhost:3000](http://localhost:3000)

### Development
Directory Structure
 - `./api` - Containes express app source
 - `./src` - Contains Angular 2 app source
 - `./config` - Contains configuration files
 - `./migrations` - Contains Sequelize CLI migration files

### Testing

Tests are not implemented yet since the app is still in architecture design process. Tests will be added after the architecture design is finalized and that codes will not be prone to massive changes.

### Technologies
- Server
    - [Express](http://expressjs.com/) as API server
    - [Sequelize](http://docs.sequelizejs.com/en/v3/) as ORM
    - [Sequelize CLI](http://docs.sequelizejs.com/en/v3/docs/migrations/) for database migrations
- Frontend
    - [Angular 2](https://angular.io/)
    - [Angular CLI](https://cli.angular.io/)

### Database Migration

We make use of Sequelize CLI in managing the database state.


 - To create a migration file, run
    ```
    $ sequelize migration:create --config ./config/development/database.json
    ```
 - To run the migrations,
    ```
    $ sequelize db:migrate --config ./config/development/database.json
    ```
 - To undo the migrations,
    ```
    $ sequelize db:migrate:undo --config ./config/development/database.json
    ```

Alternatively, I created node script files `db-migrate.js` and `migration-create.js` to make the command shorter. You'll just have to run `node db-migrate.js` to run the new migration files and `node migration-create.js` to create new migration files.

Check out the [Sequelize CLI](http://docs.sequelizejs.com/en/latest/docs/migrations/) migrations docs on how to create migrations.

### Encryption and Decryption Process
If you look at the network traffic in the browser network tab, you'll see that sensitive data sent to the server are gibberesh. This is because they are encrypted using your private key before being sent. The data is being decrypted in the client side using the same key you supplied. The key is stored in your browser's localStorage and is never sent to the server. Therefore, only you can be able to access your data.

To increase the security, the data is also encrypted in the server before saving to the database, which adds a second layer of security.

The encryption and decryption process happens inside [./src/app/services/crypto.service.ts](./src/app/services/crypto.service.ts) on the client-side and [./api/services/crypto.coffee](./api/services/crypto.coffee) on the server-side.

The data is ecnrypted using [Advanced Encryption System (AES)](https://en.wikipedia.org/wiki/Advanced_Encryption_Standard), the most widely used and trusted encryption algorithm.

**Encryption Specifications** (both server and client)
 - Algorithm = `AES`
 - Mode = `CBC`
 - Padding = `Pkcs7`
 - Key Derivation Function = `PBKDF2`
 - Key Size = `256`
 - Initialization Vector Size = `128`
 - PBKDF2 iterations = `500`

### Author
[Adones Pitogo](http://adonespitogo.com)

### License
Released under the terms of [MIT](https://opensource.org/licenses/MIT) License.
