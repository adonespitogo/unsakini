User = require('./user')
List = require('./list')
Item = require('./item')

# associations
User.hasMany(List)
List.belongsTo(User)
List.hasMany(Item)
Item.belongsTo(List)

module.exports = {
  User: User
  List: List
  Item: Item
}