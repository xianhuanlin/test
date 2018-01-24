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


util.deviceHeight = function () {
    return weex.config.env.deviceHeight;
}

util.deviceWidth = function () {
    return weex.config.env.deviceWidth;
}
util.isIos = function () {
    const { platform } = weex.config.env;
    return platform.toLowerCase() === 'ios';
}
util.isIPhoneX = function () {
    const { deviceHeight } = weex.config.env;
    return util.isIos() && deviceHeight === 2436;
}

util.getPageHeight = function(){
    const { env } = weex.config;
    const navHeight = 0;//Utils.env.isWeb() ? 0 : (Utils.env.isIPhoneX() ? 176 : 132);
    return env.deviceHeight / env.deviceWidth * 750 - navHeight;
}
export default util

