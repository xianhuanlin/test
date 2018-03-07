var apdapter =  require('./DataAdapter')
var util = require('../util')
var userManager = new Object();

userManager.tokenCache = {};

userManager.addUser = function (params,add_result) {
    apdapter.query(apdapter.types.USER,params,function (ret) {
        if (add_result){
            add_result(ret)
        }
    })

    // result(true);
};

userManager.genToken = function (user,pwd) {
    if (user && pwd){
        var token = ''

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