#/usr/bin/bash
# use to test if all production vars are picked up by the app
export NODE_ENV='production'
export DATABASE_URL='mysql://root@127.0.0.1/unsakini'
export MAILER_HOST='smtp.gmail.com'
export MAILER_SECURE_CONNECTION=true
export MAILER_PORT=465
export MAILER_AUTH_PASSWORD=''
export JWT_TOKEN='jwtoken here!!!'
export CRYPTO_PASSPHRASE='crypto pass CRYPTO_PASSPHRASE production'
export CRYPTO_IV='crypto iv production'

npm start