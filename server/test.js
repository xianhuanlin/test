 // var t = 'http://group/item/detail/get?stock_code=1416&app_channel=AppStore&version=3.1.0&plat=ios&session_token=5ff24eebce6390e2f90b5da2e2802103&api_sign=032cbaf8c8e0dae6c1596ab2e5c6b884&format=json&version_code=253&device_id=1602abeaa1556af39a48b03d9ca3e5a0&activity_key=LY1OFCKFR&access_token=c4b418e5d245b62d5175c74253fd662d&app_key=fd90275976d7da4333f08050c9bbd4ee HTTP/1.1'
//
 var util =  require('./util')
 //require(lodash/add)
 // lodash/add.js
 var _ = require('lodash');

 var CryptoJS = require("crypto-js");
 var com = {}


 var cd = '123'
 var bb = '1234'
 if (cd == bb){
     console.log('ok')
 }

 com.cd = 11
 com['123'] = 'abcd'

 for (a in com){
     console.log(a)
 }
var genToken = function (user,pwd) {
     if (user && pwd){

         var token = user + pwd + Date.now().toString()
         console.log(token)

         this.tokenCache
     }


 }
 // Encrypt
 var date = new Date()
 console.log(date.toJSON())
 console.log(CryptoJS.MD5(new Date().toUTCString()).toString());
 // var ciphertext = CryptoJS.AES.encrypt('my message', 'secret key 123');
 // console.log(ciphertext.toString());
 // // Decrypt
 // var bytes  = CryptoJS.AES.decrypt(ciphertext.toString(), 'secret key 123');
 // var plaintext = bytes.toString(CryptoJS.enc.Utf8);
 //
 // console.log(plaintext);

//  var a = new Date()
//  console.log(util.currentStamp())
//  console.log(util.formatData(a,'YYYY M dd hh:mm'))
//
// console.log(_.random(1,50000))
//  console.log(_.split('ab_cd','+'))
//
//  var users = [11,22,33]
//  var pdws = [{user:11,pwd:22},{user:2,pwd:66},{user:7,pwd:99},]
//  console.log(_.filter(users, function (e) {
//      return e >= 22
//  }));
//
//  console.log(_.map(pdws,'pwd'))
//  var str = 'cd 12'
//
//  console.log( str.split(' ')[0])