const http = require('http');
const hostname = '127.0.0.1';
const port = 300;

function loadHTML() {
    fetch('homePage.html')
        .then(response => response.text())
        //.then(text => document.getElementById('homePage').innerHTML = text);
  }

const server = http.createServer((req, res) => {

    res.statusCode = 200;
    res.setHeader('Content-Type', 'text/html');
    //res.end('');

    loadHTML();

    

});

server.listen(port, hostname, () => {console.log('Server running at http://'+ hostname + ':' + port + '/');});