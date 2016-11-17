UNSAKINI
-----------

**[Unsakini](https://www.unsakini.com)** is an open source encrypted bulletin board created to protect online activists from digital information surveillance and protect data secrecy. Made on top of [Rails 5](http://rubyonrails.org/) and [Angular 2](https://angular.io/).

### Features
 - Encrypted Bulletin Boards
 - Share Encrypted Files
 - Group Forums

-------------------------

### How it Works
Upon using the system, you'll be asked to provide your private key. This key is used to encrypt your data before it is sent to the server. If you look at the network traffic in the browser network tab (by pressing F12 and selecting network tab), you'll see that sensitive data sent to the server are gibberesh. This is because they are encrypted using your private key before it leaves your computer. The key is stored in your browser and is never sent to the server. Only you have access to your private key.

To increase the security, the data is also encrypted in the server before being saved to the database, which adds a second layer of encrypion.

The data is ecnrypted using [Advanced Encryption System (AES)](https://en.wikipedia.org/wiki/Advanced_Encryption_Standard), the most widely used and trusted encryption algorithm.

### System Requirements
 - Node.js < 7.0.0
 - Ruby >= 2.2.2
 - Mysql

### Installation

```
$ git clone https://github.com/adonespitogo/unsakini.git my-project
$ cd my-project
$ bundle install
$ cd angular
$ npm install -g angular-cli gulp
$ npm install
```

### Configurations
 - Rails configurations can be found `./config` directory. Feel free to modify as needed, specially the database configuration. See the rails setup [documentation](./docs/rails.md).
 - Angular app is managed using [Angular CLI](https://github.com/angular/angular-cli). See the frontend [configuration](./docs/angular.md).

### Running Local Server
Navigate to project root directory
```
$ cd my-project
```
Run setup database
```
$ rake db:setup
```
Run local Rails server
```
$ rails s
```
Browse [http://localhost:3000](http://localhost:3000)

### Documentations
 - The backend is a traditional [Rails 5](http://rubyonrails.org/) app. See the [YARD documentation](https://www.unsakini.com/docs/backend/).
 - The frontend is made of [Angular 2](https://angular.io/). See the [documentation](https://www.unsakini.com/docs/frontend/).

### Testing
 - Using [Rspec](http://rspec.info/) in testing Rails backend
 - See [Angular 2 Testing Guide](https://angular.io/docs/ts/latest/guide/testing.html)

Run rails tests
```
$ rspec
```
Run angular tests
```
Not yet implemented!
```

### Encryption Specifications

  - server
    - Algorithm = `AES`
    - Mode = `CBC`
    - Key Size = `256`
    - *Others = autogenerated, random
  - client
    - Algorithm = `AES`
    - Mode = `CBC`
    - Padding = `Pkcs7`
    - Key Derivation Function = `PBKDF2`
    - Key Size = `256`
    - Initialization Vector Size = `128`
    - PBKDF2 iterations = `500`

### Security
  If you find any security flaws, please don't write a github issue. Email me instead at pitogo.adones@gmail.com so we can fix it before the public knows.

### Author
[Adones Pitogo](http://adonespitogo.com)

### License
Released under the terms of [MIT](https://opensource.org/licenses/MIT) License.
