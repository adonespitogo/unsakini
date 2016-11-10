require('shelljs/global');
var env = process.env.NODE_ENV || 'development'

exec('typings install');
exec('npm rebuild node-sass');
if (env === 'development') {
  exec('gulp init:config');
}
exec('node db-migrate.js');
exec('gulp build');
