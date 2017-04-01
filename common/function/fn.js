module.exports = {
  now: (type) => {return type && new Date().getTime() || Math.floor(new Date().getTime()/1000);},
}