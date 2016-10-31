
var q = require('q');

'use strict';

module.exports = {
  up: function(queryInterface, Sequelize) {
    /*
      Add altering commands here.
      Return a promise to correctly handle asynchronicity.

      Example:
      return queryInterface.createTable('users', { id: Sequelize.INTEGER });
    */
    var promises = [];
    promises.push(queryInterface.changeColumn('lists', 'name', Sequelize.TEXT));
    promises.push(queryInterface.changeColumn('items', 'title', Sequelize.TEXT));
    promises.push(queryInterface.changeColumn('items', 'content', Sequelize.TEXT));
    return q.all(promises);
  },

  down: function(queryInterface, Sequelize) {
    /*
      Add reverting commands here.
      Return a promise to correctly handle asynchronicity.

      Example:
      return queryInterface.dropTable('users');
    */
  }
};
