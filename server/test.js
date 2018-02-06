 // var t = 'http://group/item/detail/get?stock_code=1416&app_channel=AppStore&version=3.1.0&plat=ios&session_token=5ff24eebce6390e2f90b5da2e2802103&api_sign=032cbaf8c8e0dae6c1596ab2e5c6b884&format=json&version_code=253&device_id=1602abeaa1556af39a48b03d9ca3e5a0&activity_key=LY1OFCKFR&access_token=c4b418e5d245b62d5175c74253fd662d&app_key=fd90275976d7da4333f08050c9bbd4ee HTTP/1.1'
//
 var util =  require('./util')

var querystring = require('querystring');

var t = 'http?uid=11_22&id=22'
 console.log(util.version)
 console.log(util.parse(t))