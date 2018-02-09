var util =  require('../util')
var root = require('./serviceRooter')

 console.log(util.version)
//
// var http = require('http');
// var data = {a:11,b:22}

var srv = http.createServer(function (req, res) {
    // console.log(req.url)
    // console.log(req)

    root.handleReq(req,function (handleData) {
        res.writeHead(200, {'Content-Type': 'application/json'});
        res.end(JSON.stringify(handleData));
    })
});

srv.listen(8080, function() {
    console.log('listening on localhost:8080');
});