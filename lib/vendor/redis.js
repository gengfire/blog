const redis = require('redis');
const path  = require('path');
const config = require(path.resolve(ROOT, 'common/conf/config'));

const redi = redis.createClient(config.redis.port, config.redis.host, {
  prefix: config.redis.prefix || ''
});
redi.auth(config.redis.auth);

redi.on("error", function (err) {
  console.log("Error " + err);
});

module.exports = redi;