

var util = new Object()

util.verSign = "1.1.1"

util.srcRoot = "http://192.168.0.105:8081/"

util.parseUrl = function (url) {
    //if (!url.indexOf('?')  url.indexOf)
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

util.formatObj = function (obj) {
    return JSON.stringify(obj)
}

util.safeAssign = function (a,b) {
    if (b){
        a = b
    }
}


util.formatStamp = function(stamp,fmt)
{
    var date = new Date(stamp)
    return this.formatData(date, fmt)
}

util.formatData = function(date,fmt)
{
    var str = fmt;
    var Week = ['日','一','二','三','四','五','六'];

    str=str.replace(/yyyy|YYYY/,date.getFullYear());
    str=str.replace(/yy|YY/,(date.getYear() % 100)>9?(date.getYear() % 100).toString():'0' + (date.getYear() % 100));

    str=str.replace(/MM/,date.getMonth()>9?data.getMonth().toString():'0' + (date.getMonth() + 1));
    str=str.replace(/M/g,date.getMonth() + 1);

    str=str.replace(/w|W/g,Week[date.getDay()]);

    str=str.replace(/dd|DD/,date.getDate()>9?date.getDate().toString():'0' + date.getDate());
    str=str.replace(/d|D/g,date.getDate());

    str=str.replace(/hh|HH/,date.getHours()>9?date.getHours().toString():'0' + date.getHours());
    str=str.replace(/h|H/g,date.getHours());
    str=str.replace(/mm/,date.getMinutes()>9?date.getMinutes().toString():'0' + date.getMinutes());
    str=str.replace(/m/g,date.getMinutes());

    str=str.replace(/ss|SS/,date.getSeconds()>9?date.getSeconds().toString():'0' + date.getSeconds());
    str=str.replace(/s|S/g,date.getSeconds());

    return str;
}



export default util

