

UNSAKINI
-----------
*Created by and for online activists, information security enthusiasts and government surveillance evaders.*


**[Unsakini](https://www.unsakini.com)** is an open source encrypted bulletin board created with the aim of evading global information surveillance and spying, preventing data leaks and promoting information confidentiality and integrity.

Perfect for:

 - group discussions on sensitive issues
 - confidential conversations
 - storing passwords, liscenses, credit card details, and other sensitive documents


-------------------------

### How it Works
Upon using the system, you'll be asked to provide your private key. This key is used to encrypt your data before it is sent to the server. If you look at the network traffic in the browser network tab (by pressing F12 and selecting network tab), you'll see that sensitive data sent to the server are gibberesh. This is because they are encrypted using your private key before it leaves your web browser. The key is stored in your computer and is never sent to the server. Only you have access to your private key, thus only you can read your data.

Hackers, surveillance and spy softwares and even the server host cannot read your data, unless they are able to obtain your private key. Your private key is deleted from your computer once you logout.

To increase the security, your data is re-encrypted in the backend before being saved to the database, which adds a second layer of protection.

So to access your data, the hacker needs to know two things - (1) your private key and (2) the server encryption key. That is, if they are able to bypass the server security and gets access to the database. Even so, they won't be able to read the data without these two elements.

The data is ecnrypted using [Advanced Encryption System (AES)](https://en.wikipedia.org/wiki/Advanced_Encryption_Standard), the most widely used and trusted encryption algorithm.

------

### System Requirements
 - Node.js
 - Ruby >= 2.2.2
 - `rails` and `bundler` gems

### Installation

```
$ rails new my-app
$ cd my-app
```
Add `gem 'unsakini'` to your Gemfile.
```bash
$ bundle install
```
Generate the `config/initializers/unsakini.rb`
```
$ rails g unsakini:config # 
```
Generate the frontend assets
```
$ rails g unsakini:angular 
```
Build the angular app
```
$ rake unsakini:build
```
Populate the db/migrations directory
```
$ rake unsakini_engine:install:migrations
```
Setup the database
```
$ rake db:migrate
```

Run local rails server
```
$ rails s
```
Now you will be able to see the application at [http://localhost:3000](http://localhost:3000)

------------------------------

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

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
