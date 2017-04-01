const authController = require('../common/controller/authController');

module.exports = class Controller extends authController {

  indexAction () {
    this.exesql('SELECT tb1.title, tb2.cat_name FROM note tb1 LEFT JOIN category tb2 ON tb1.cat_id=tb2.id', ret => {
      this.display({
        list: ret
      });
    });
  }

  listAction () {
    this.exesql('SELECT tb1.title, tb2.cat_name FROM note tb1 LEFT JOIN category tb2 ON tb1.cat_id=tb2.id', ret => {
      this.json('200', ret);
    });
  }

  // tplAction () {
  //   this.display({name: 'hello'}, 'index/tpl');
  // }

  // detailAction (req, res) {
  //   this.exesql('SELECT title FROM note WHERE id=' + this.param, ret => {
  //     res.send(ret);
  //   });
  // }

  // redisAction (req, res) {
  //   this.redis.set('username', 'test');

  //   this.redis.get('username', function(rq, ret){
  //     res.send(ret);
  //   });
  // }
}