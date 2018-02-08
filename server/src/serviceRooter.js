var serviceRooter = new Object()

serviceRooter.handleReq = function (req) {
    if (req.url.indexOf('user/') >= 0){

    }
    else if (req.url.indexOf('order') >= 0){

    }else if (req.url.indexOf('cart') >= 0){

    }else if (req.url.indexOf('sku') >= 0){

    }else if (req.url.indexOf('cart') >= 0){

    }

}

module.exports = serviceRooter;