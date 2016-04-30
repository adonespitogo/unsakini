gulp = require('gulp')
coffee = require('gulp-coffee')
rename = require('gulp-rename')
concat = require('gulp-concat')
templateCache = require('gulp-angular-templatecache')
uglify = require('gulp-uglify')
strip_debug = require('gulp-strip-debug')
helpers = require('./helpers')

renameJS = (path) ->
  path.basename = path.basename.replace('.js.coffee', '');
  path.basename = path.basename.replace('.coffee', '');
  path.basename = path.basename.replace('.js', '');
  path.extname  = '.js';

vendor_js_files = [
  "./web/js/libs/markdown.js"
  "./bower_components/jquery/dist/jquery.js"
  "./bower_components/lodash/lodash.js"
  "./bower_components/jStorage/jstorage.js"
  "./bower_components/cryptojslib/rollups/aes.js"
  "./bower_components/angular/angular.js"
  "./bower_components/angular-cookies/angular-cookies.js"
  "./bower_components/angular-sanitize/angular-sanitize.js"
  "./bower_components/angular-ui-router/release/angular-ui-router.js"
  "./bower_components/angular-http-auth/src/http-auth-interceptor.js"
  "./bower_components/angular-bootstrap/ui-bootstrap.js"
  "./bower_components/angular-bootstrap/ui-bootstrap-tpls.js"

  #RDash Admin template
  "./web/js/libs/rdash.js"
  "./web/js/libs/loading.js"
  "./web/js/libs/widget.js"
  "./web/js/libs/widget-body.js"
  "./web/js/libs/widget-header.js"
  "./web/js/libs/widget-footer.js"
  "./web/js/libs/rdash-master-ctrl.js"
]

app_tmp_js_files = [
  '.tmp/app/js/app.js'
  '.tmp/app/js/config.js'
  '.tmp/app/js/routes.js'
  '.tmp/app/js/controllers/*.js'
  '.tmp/app/js/directives/*.js'
  '.tmp/app/js/services/*.js'
  '.tmp/app/js/filters/*.js'
  '.tmp/app/js/templates.js'
  '.tmp/app/js/login.js'
]

gulp.task 'app:coffee', ['clean:tmp'], ->
  gulp.src("./web/js/**/*.coffee")
      .pipe(coffee())
      .on('error', helpers.swallowError)
      .pipe(rename(renameJS))
      .pipe(gulp.dest('.tmp/app/js'))


gulp.task 'templates', ['clean:tmp'], ->
  gulp.src('web/views/**/*.html')
      .pipe(templateCache({
        standalone:true
      }))
      .pipe(gulp.dest('.tmp/app/js'))

gulp.task 'js:concat', ['app:coffee', 'templates'], ->
  files = vendor_js_files.concat(app_tmp_js_files)
  gulp.src(files)
      .pipe(concat('application.js'))
      .pipe(gulp.dest('.tmp/app/js/concat'))

gulp.task 'uglify', ['js:concat', 'templates', 'app:coffee'], ->
  stream = gulp.src('.tmp/app/js/concat/application.js')

  if (process.env.debug isnt 'true')
    stream.pipe(strip_debug())

  if (process.env.NODE_ENV is 'production')
    stream
    .pipe(uglify())

  stream.pipe(gulp.dest('.tmp/app/js/uglify'))
