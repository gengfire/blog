module.exports = class authController {
  constructor (req, res) {
    this.req = req;
    this.res = res;
  }

  __before (next) {
    const token = this.getCookie().auth;
    
    if (!token) {
      this.redirect('/user/login');
    } else {
      this.exesql(`SELECT id FROM user WHERE token='${token}'`, ret => {
        if (ret.length === 0) return this.redirect('/user/login');

        next(() => {
          this.uid = ret[0].id;
        });
      });
    }
  }
}