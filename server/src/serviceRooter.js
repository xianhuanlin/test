var userManager = require('./userManager')

var serviceRooter = new Object()

serviceRooter.handleReq = function (req, ret) {
    this.req = req
    var params = req.url.split('?')[1]
    if (req.url.indexOf('user/') >= 0){
        userManager.handleReq(params, function (rsp) {
            ret(rsp);
        })
    }
    else if (req.url.indexOf('order') >= 0){

    }else if (req.url.indexOf('cart') >= 0){

    }else if (req.url.indexOf('sku') >= 0){

    }else if (req.url.indexOf('cart') >= 0){

    }

}

module.exports = serviceRooter;