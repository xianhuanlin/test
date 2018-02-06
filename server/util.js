var querystring = require('querystring');
var util = new Object()

util.version = 1120

util.parse = function (url) {
    var index = url.indexOf('?')
    if (index >= 0){
        var params = url.slice(index + 1)

        return querystring.parseparse(params)
    }

    return []
}



module.exports = util;