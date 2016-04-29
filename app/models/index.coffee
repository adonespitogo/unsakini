User = require('./user')
List = require('./list')
Item = require('./item')

# associations
List.belongsTo(User)
Item.belongsTo(List)
List.hasMany(Item)

module.exports = {
  User: User
  List: List
  Item: Item
}