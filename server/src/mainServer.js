
var util =  require('../util')


 console.log(util.version)
//
var http = require('http');

var srv = http.createServer(function (req, res) {
    console.log(req.url)

    res.writeHead(200, {'Content-Type': 'application/json'});
    res.end(JSON.stringify(testData.dataDetail));
});

srv.listen(8080, function() {
    console.log('listening on localhost:8080');
});