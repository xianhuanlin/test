var apdapter =  require('./DataAdapter')
var util = require('../util')
var userManager = new Object();
//http://localhost:8080/user/register?user=123&pwd=123
userManager.addUser = function (params,result) {
    // apdapter.query(apdapter.types.USER)

    result(true);
};

userManager.editUserPwd = function (name,pdw,newPwd,result) {

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
                if (ret){
                    rsp({code:100})
                }else{
                    rsp({code:-10000})
                }
            })
        }

    }
}

module.exports = userManager