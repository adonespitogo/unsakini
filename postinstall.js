
require('shelljs/global');
var env = process.env.NODE_ENV || 'development'

exec('typings install');
exec('npm rebuild node-sass');
exec('node db-migrate.js');
exec('ng build ' + (env === 'production' ? '--prod' : '') );