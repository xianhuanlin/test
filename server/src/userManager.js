var apdapter =  require('./DataAdapter')
var util = require('../util')
var userManager = new Object();
//http://localhost:8080/user/register?user=123&pwd=123
userManager.addUser = function (params,add_result) {
    apdapter.query(apdapter.types.USER,params,function (ret) {
        if (add_result){
            add_result(ret)
        }
    })

    // result(true);
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

    }
}

module.exports = userManager