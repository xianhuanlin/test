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

util.currentStamp = function () {
    var date = new Date()
    return Date.parse(date)
}
module.exports = util;