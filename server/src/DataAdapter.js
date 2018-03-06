

var MongoClient = require('mongodb').MongoClient;
var DB_CONN_STR = 'mongodb://xianhuan2:123456@localhost:27017/admin';

var tableTypes = {
    USER:'user',
    ORDER:'order',
    SKU:'sku',
}

var selectData = function(db, callback) {
    //连接到表
    var collection = db.collection('user');
    //查询数据
    var whereStr = {"user":'xue'};
    collection.find(whereStr).toArray(function(err, result) {
        if(err)
        {
            console.log('Error:'+ err);
            return;
        }
        callback(result);
    });
}
//
// MongoClient.connect(DB_CONN_STR, function(err, db) {
//
//     if (err){
//         console.log(err)
//         return;
//     }else{
//         console.log("连接成功！");
//     }
//     // console.log(db)
//     var data = {user:'xianhuan',pwd:'123456789'}
//     var data2 = {user:'xianhuan2',pwd:'123456789'}
//
//     var collection = db.db('poke').collection('user');
//     // var collection = db.db('poke').collection('user2');
//     //查询数据
//     var whereStr = {"username":'lxh'};
//     collection.find(whereStr).toArray(function(err, result) {
//         if(err)
//         {
//             console.log('Error:'+ err);
//             return;
//         }
//         console.log(result)
//     });
//     collection.insert(data2,function (err,result) {
//         // db.close()
//     })
//     // collection.insertOne()
// });


var DataAdapter = {isOk:false,types:tableTypes}

DataAdapter.startService = function (ret) {
    if (this.isOk){
        return;

    }
    this.isOk = true;
    var self = this;
    MongoClient.connect(DB_CONN_STR, function(err, db) {
        if (!err){
            self.dataBase = db//.collection('user');
        }
        ret(err);
    });

}

DataAdapter.query = function (type,state,ret) {
    console.log(this.dataBase.db)
    var collection = this.dataBase.db('poke').collection(type);

    collection.find(state).toArray(function(err, result) {
        if(err || !result || result.length == 0)
        {
            //console.log('Error:'+ err);
            ret(null);
            return;
        }else{
            ret(result)
            // collection.insertOne()

        }
        // console.log(result)
    });
}

DataAdapter.add = function (type,state,ret) {
    var collection = this.dataBase.db('poke').collection(type);

    collection.find(state).toArray(function(err, result) {
        if(result && result.length > 0)
        {
            ret({msg:"already has the same record'"});
            return;

        }else{
            collection.insertOne(state,function (err,result) {
                if (!err){
                    ret({});
                }else{
                    ret({msg:"can not add this record" + err.toString()})
                }
            })
        }
    });
};

DataAdapter.delete = function (type,state,ret) {
    var collection = this.dataBase.db('poke').collection(type);
    collection.deleteOne(state,function (err,result) {
        console.log(result)
        ret(result)
    })
}
;
DataAdapter.update = function (type,state,newState,ret) {
    var collection = this.dataBase.db('poke').collection(type);
    collection.updateMany(state,newState,function (err,result) {
        if (ret){
            ret(result)
        }
        console.log( err)
        console.log(result)
    })
}
DataAdapter.stopService = function () {
    this.isOk = false;
    this.dataBase.close()
    this.dataBase = null
};

DataAdapter.types = tableTypes;

DataAdapter.startService(function (err) {
     if (!err){
         // DataAdapter.delete(DataAdapter.types.USER,{user:'lxh222',pwd:1222},function (ret) {
         //     DataAdapter.stopService();
         //     console.log(DataAdapter.dataBase)
         // })
         DataAdapter.update(DataAdapter.types.USER,{pwd:1234},{$set:{pwd:4567}},function (result) {
             DataAdapter.stopService();
         })

     }

 });

module.exports = DataAdapter;