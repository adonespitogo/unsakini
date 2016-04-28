var gutil = require('gulp-util');

module.exports = {
  swallowError: function swallowError (err) {
    gutil.log(err);
    gutil.beep();
    this.emit('end');
  }

};