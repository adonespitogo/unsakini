
var env = process.env.NODE_ENV || 'development'
require('shelljs/global');

exec('sequelize migration:create --config config/' + env + '/database.json');