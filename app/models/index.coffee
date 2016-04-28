User = require('./user')
List = require('./list')

# associations
List.belongsTo(User)

module.exports = {
  User: User
  List: List
}