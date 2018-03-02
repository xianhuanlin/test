

var MongoClient = require('mongodb').MongoClient;
var DB_CONN_STR = 'mongodb://root:root@localhost:27017/admin';

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

MongoClient.connect(DB_CONN_STR, function(err, db) {

    if (err){
        console.log(err)
        return;
    }else{
        console.log("连接成功！");
    }
    // console.log(db)
    var data = {user:'xianhuan',pwd:'123456789'}
    var data2 = {user:'xianhuan2',pwd:'123456789'}

    var collection = db.db('poke').collection('user');
    // var collection = db.db('poke').collection('user2');
    //查询数据
    var whereStr = {"username":'lxh'};
    collection.find(whereStr).toArray(function(err, result) {
        if(err)
        {
            console.log('Error:'+ err);
            return;
        }
        console.log(result)
    });
    collection.insert(data2,function (err,result) {
        // db.close()
    })
    // collection.insertOne()
});


var DataAdapter = {isOk:false}

DataAdapter.startService = function (ret) {
    if (this.isOk){
        return;

    }
    this.isOk = true;

    MongoClient.connect(DB_CONN_STR, function(err, db) {
        if (!err){
            this.dataBase = db.db('poke')//.collection('user');
        }
        ret(err,db);
    });

}

DataAdapter.query = function (type,state,ret) {
    var collection = db.db('poke').collection(type);

    collection.find(state).toArray(function(err, result) {
        if(err)
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
    var collection = db.db('poke').collection(type);

    collection.find(state).toArray(function(err, result) {
        if(err)
        {
            //console.log('Error:'+ err);
            ret({msg:"already has the same record'"});
            return;
        }else{
            collection.insert(state,function (err,result) {
                if (!err){
                    ret({});
                }else{
                    ret({msg:"can not add this record" + err.toString()})
                }
            })

            //ret(result);
        }
        // console.log(result)
    });
};

DataAdapter.delete = function (type,state,ret) {
    var collection = db.db('poke').collection(type);
    //collection.deleteOne()
}
;
DataAdapter.update = function (type,state,ret) {

}
DataAdapter.stopService = function () {
    this.isOk = false;
};

DataAdapter.types = tableTypes;

// DataAdapter.startService();

console.log(DataAdapter.isOk);

module.exports = DataAdapter;