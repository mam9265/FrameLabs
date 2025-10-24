const http = require('http');
const hostname = '127.0.0.1';
const port = 300;
const fs = require('fs')

const fileContents = fs.readFileSync('homePage.html').toString()

const server = http.createServer((req, res) => {

    res.statusCode = 200;
    res.setHeader('Content-Type', 'text/html');

    res.end(fileContents);

});

//server.listen(port, hostname, () => {console.log('Server running at http://'+ hostname + ':' + port + '/');});
