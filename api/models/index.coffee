User = require('./user')
List = require('./list')
AccountConfirmation = require('./account_confirmation')
Item = require('./item')

# associations
User.hasMany(List)
List.belongsTo(User)
User.hasMany(AccountConfirmation)
AccountConfirmation.belongsTo(User)
List.hasMany(Item)
Item.belongsTo(List)

module.exports = {
  User: User
  List: List
  Item: Item
  AccountConfirmation: AccountConfirmation
}
