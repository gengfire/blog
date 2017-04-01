module.exports = {
  mysql: {
    host: '127.0.0.1',
    user: 'blog',
    password: '123456',
    database: 'blog',
    prefix: 'mu_'
  },
  redis: {
    host: '127.0.0.1',
    port: 6379,
    auth: '123456',
    prefix: 'mu_'
  },
  cache: true
}