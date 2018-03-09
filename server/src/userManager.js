var apdapter =  require('./DataAdapter')
var util = require('../util')
var userManager = new Object();
var CryptoJS = require("crypto-js");

userManager.tokenCache = {};
userManager.tokenTiems = 3600*24;
userManager.addUser = function (params,add_result) {
    apdapter.query(apdapter.types.USER,params,function (ret) {
        if (add_result){
            add_result(ret)
        }
    })

    // result(true);
};

userManager.checkToekn = function (user,token) {
    var stamp = Date.now()

    var tokenData = this.tokenCache[user]
    if (!tokenData || user != token.user){
        return false
    }
    if (tokenData.token == token && tokenData.time - stamp > this.tokenTiems ){
        return false
    }
    else{
        return true
    }
}

userManager.genToken = function (user,pwd) {
    if (user && pwd){

        var stamp = Date.now()
        var token = user + pwd + stamp.toString()
        console.log(token)
        if (!token || token.length == 0){
            console.log('error,token length is 0')
            return;
        }

        this.tokenCache[token] = {token:CryptoJS.MD5(token),time:stamp,user:user};
    }

    if (!this.tokenCheck){
        this.tokenCheck = true
        setInterval(function () {
            userManager.clearToken()
        },600000)
    }
}

userManager.clearToken = function () {
    for (key in this.tokenCache){
        var tokenData = this.tokenCache[key]
        if (Date.now() - tokenData.stamp > this.tokenTiems){
            this.tokenCache[key] = undefined;
        }
    }

}

userManager.login = function (user,pwd,result) {
    apdapter.query(apdapter.types.USER,{user:user,pwd:pwd},function (ret) {
        if (add_result){
            add_result(ret)
        }
    })
};

userManager.editUserPwd = function (name,state,result) {

};

userManager.handleReq = function (url, rsp) {
    if (url){
        var params = util.parse(url)
        if (url.indexOf('register')){
            if (apdapter.isOk == false){
                rsp({code:-100})
                return;
            }

            this.addUser(params, function (ret) {
                var data = ret;
                if (ret){
                    data.code = 100;
                    rsp(data)
                }else{
                    data.code = -10000;
                    rsp(data)
                }
            })
        }
        else if (url.indexOf('login')){

        }
        else if (url.indexOf('logout')){

        }
        else if (url.indexOf('edit')){

        }
        else if (url.indexOf('delete')){

        }
    }
}



module.exports = userManager