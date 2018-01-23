var util = new Object()

util.verSign = "1.1.1"

util.srcRoot = "http://192.168.0.105:8081/"

util.parseUrl = function (url) {
    var query = url.split("?")[1];
    var queryArr = query.split("&");
    var obj = {};
    queryArr.forEach(function(item){

        var value = item.split("=")[1];
        var key = item.split("=")[0];
        obj[key] = value;

    });
    return obj;
}
util.test = function (a,b) {
    return a + b
}


export default util

