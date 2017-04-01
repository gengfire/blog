module.exports = class Controller {

  loginAction() {
    this.display();
  }

  signinAction(req, res) {
    this.setCookie({
       auth: true
    });
    this.json('200');
  }
}