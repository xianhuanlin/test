var MongoClient = require('mongodb').MongoClient;
 var DB_CONN_STR = 'mongodb://root:root@localhost:27017/admin';
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
    var collection = db.db('poke').collection('user');
    //查询数据
    var whereStr = {"username":'lxh'};
    collection.find(whereStr).toArray(function(err, result) {
        if(err)
        {
            console.log('Error:'+ err);
            return;
        }
        console.log(result)
        // callback(result);
    });
});