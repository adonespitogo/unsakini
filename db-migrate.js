
var env = process.env.NODE_ENV || 'development'
require('shelljs/global');

exec('sequelize db:migrate --config config/' + env + '/database.json');