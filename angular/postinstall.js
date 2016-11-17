var env = process.env.NODE_ENV || 'development'

exec('typings install');
exec('npm rebuild node-sass');
exec('gulp build');
