const ROOT  = global.ROOT = __dirname;
const path  = require('path');
const fn    = require(path.resolve(ROOT, 'common/function/fn'));
const mysql = require(path.resolve(ROOT, 'lib/vendor/mysql'));
const redis = require(path.resolve(ROOT, 'lib/vendor/redis'));

const App = require(path.resolve(ROOT, 'lib/App'));

const app = new App(ROOT, 'web', {
  fn,
  exesql: mysql.exesql
});

app.start(30);