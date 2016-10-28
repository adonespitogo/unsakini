module.exports = {
  base_url: if process.env.NODE_ENV is 'production' then "https://www.unsakini.com" else 'http://localhost:3000'
}
