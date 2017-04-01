'use strict';

const http = require('http');
const fs = require('fs');
const url = require('url');
const querystring = require('querystring');
const path = require('path');
const commonConf = require('./conf/defaults.json');
const config = require(path.resolve(ROOT, 'common/conf/config'));

class App {
  constructor(root, project, extend = {}, artOption = {}) {
    this.config = Object.assign(commonConf, config);

    this.realPath = path.resolve(root, project);
    this.extend = extend;

    this.artOption = Object.assign({}, artOption);
  }

  start (port) {
    http.createServer((req, res) => {
      const fileInfo = path.parse(req.url);
      res.send = (content='') => {
        this.writeHead(res);
        res.end('object' === typeof content && JSON.stringify(content) || content);
      };

      // static
      if (fileInfo.ext !== '') {

        if (fileInfo.name === '' && fileInfo.dir !== this.config.STATIC_DIR) return res.send(this.config.NOT_FOUND);

        // assets or cache
        fileInfo.ext = fileInfo.ext.replace(/^(\.\w+)(\S+)?/, '$1');
        const fileName = path.join(fileInfo.dir,  fileInfo.name) + fileInfo.ext;
        const filePath = this.config.cache && fileInfo.dir !== this.config.STATIC_DIR && this.config.CACHE_DIR + fileName || fileName.substring(1);

        fs.readFile(path.resolve(this.realPath, filePath), (err, data) => {
          const ext = err && this.config.CONTENT_TYPE || fileInfo.ext.slice(1);
          const body = err && this.config.NOT_FOUND || data;
          const contentType = this.getContentType(ext);
          this.writeHead(res, contentType);
          res.write(body);
          res.end();
        });
      } else {
        const purl = url.parse(req.url);
        const curPath = purl.pathname.split('/');
        const cName = curPath[1] && curPath[1] || this.config.CNAME;
        const fName = curPath[2] && curPath[2] || this.config.FNAME;
        const param = curPath.slice(3);
        const cPath = path.resolve(path.resolve(this.realPath, this.config.CONTROLLER_DIR), cName + this.config.CONTROLLER_SUFFIX);

        let postData = '';
        req.addListener('data', data => {
          postData += data;
        });
        // when request is end
        req.addListener('end', () => {

          // cache clear
          if (fName === 'clear' && fName === 'clear') {
            this.deleteFolder(path.resolve(this.realPath, this.config.CACHE_DIR));
            return res.send('Clear Cache Succeeded');
          }

          req.data = querystring.parse(postData);

          let controller;
          try {
            controller = require(cPath);

            // extend
            for (let i in this.extend) {
              controller.prototype[i] = this.extend[i];
            };
            // return json width status
            controller.prototype.json = (code, arg1, arg2) => {
              res.send(this.json(code, arg1, arg2));
            };
            // just write
            controller.prototype.echo = (content) => {
              this.writeHead(res);
              res.write('object' === typeof content && JSON.stringify(content) || content);
            }
            // res end
            controller.prototype.end = () => { res.end() }
            // redirect
            controller.prototype.redirect = path => {
              res.writeHead(302, {
                'Location': path
              });
              res.end();
            }
            // url search
            controller.prototype.query = querystring.parse(purl.query);
            // url param >first
            controller.prototype.param = param[0] || null;
            // url params > array
            controller.prototype.params = param || [];
            // get cookies
            controller.prototype.getCookie = () => {
              const cookies = req.headers.cookie || '';
              return querystring.parse(cookies, '; ');
            }
            // set cookies
            controller.prototype.setCookie = () => {
              const expire = new Date(new Date().getTime() + 24 * 60 * 60 * 1000).toGMTString();
              res.setHeader('Set-Cookie', ['auth=true;path=/;Expires='+ expire +';httpOnly=true']);
            }

            controller = new controller(req, res);
          } catch(e) {
            console.log(cPath + ' is not existed');
          }
          if ('undefined' === typeof controller || 'function' !== typeof controller[fName + this.config.ACTION_SUFFIX]) {
            return res.send(this.config.NOT_FOUND);
          }

          // tpl render
          controller.display = (assignData = {}, tplDir) => {
            this.display(assignData, tplDir, cName, fName, html => {
              res.send(html);

              // cache
              if (!this.config.cache) return;

              const cacheDir = path.resolve(this.realPath, this.config.CACHE_DIR);
              const fileDir  = path.resolve(cacheDir, cName);
              const paramFix = param.length && '_' + param.join('_') || '';
              const filePath = path.resolve(fileDir, fName + paramFix + this.config.SUFFIX);
              // mkdir
              if (!fs.existsSync(cacheDir)) fs.mkdirSync(cacheDir);
              if (!fs.existsSync(fileDir)) fs.mkdirSync(fileDir);
              // write cache
              fs.writeFile(filePath, html, function (err) {
                if (err) console.log(err);
                console.log('saved: '+ filePath);
              });
            });
          };

          // execute function
          if ('function' === typeof controller.__before) {
            controller.__before(arg => {
              arg && arg();
              controller[fName + this.config.ACTION_SUFFIX](req, res);
            });
          } else {
            controller[fName + this.config.ACTION_SUFFIX](req, res);
          }
        });
      }
    }).listen(port);
    console.log('App start at %s', port);
  }

  display (assignData, tplDir, cName, fName, callback) {
    if (this.artOption.tpl || this.config.tpl) {
      const tplName = tplDir || path.join(cName, fName);
      const tplPath = path.resolve(path.resolve(this.realPath, this.config.VIEWS_DIR), tplName + this.config.SUFFIX);

      fs.readFile(tplPath, {encoding: 'utf-8'}, (err, data) => {
        if (err) return res.send(this.config.NOT_FOUND);
        const artTemplete = require('art-template');
        if (this.artOption.config) artTemplete.config(this.artOption.config);
        if (this.artOption.helper) {
          for (let i in this.artOption.helper) {
            artTemplete.helper(i, this.artOption.helper[i]);
          }
        }
        artTemplete.helper('urlFix', data => {return this.urlFix(data)});
        artTemplete.config('base', path.resolve(this.realPath, this.config.VIEWS_DIR));
        callback(artTemplete.compile(data, {
          filename: tplName + this.config.SUFFIX  // for Nodejs get current path, base on base_path
        })(assignData));
      });
    } else {
      callback(this.config.NOT_FOUND);
    };
  }

  urlFix (data) {
    const url = data.split('/').slice(1);
    return ['', url.shift(), url.join('_')].join('/') + this.config.SUFFIX;
  }

  deleteFolder (path) {
    if(fs.existsSync(path)) {
      const files = fs.readdirSync(path);
      files.forEach(file => {
        const curPath = path + '/' + file;
        if(fs.statSync(curPath).isDirectory()) {
          this.deleteFolder(curPath);
        } else {
          fs.unlinkSync(curPath);
        }
      });
      fs.rmdirSync(path);
    }
  }

  getContentType (ext) {
    const type = this.config.STATIC_TYPE;
    return type[ext] || type['txt'];
  }

  writeHead (res, contentType = 'text/html') {
    res.writeHead(200, {'Content-Type': contentType + ';charset=utf-8'});
  }

  json(code, arg1, arg2) {
    const resCode = this.config.RES_CODE;
    let ret = {
      'status': Number(code),
      'msg': 'string' !== typeof arg1 ? (resCode[code] ? resCode[code] : code) : arg1
    };
    if ('string' === typeof arg1) {
      if (arg2) ret.data = arg2;
    } else {
      if (arg1) ret.data = arg1;
    }
    return ret;
  }
}

module.exports = App;