<template>
    <!--<div class="home2">-->
            <list class="list2" @loadmore="fetch" loadmoreoffset="10" @viewappear="viewApear">
                <cell>
                    <image class="top2image" src="../res/top2.png">


                    </image>
                    <image class="top1image" src="../res/top1.png">
                    </image>
                </cell>
                <cell class="cell" v-for="num in lists">
                    <div class="block">
                        <div class="block2">
                            <image src="http://image.watsons.com.cn//upload/fa42b3df.jpg" class="mainimage">

                            </image>
                        </div>
                        <div class="block3">
                            <text class="text2">{{num.c}}</text>
                            <text class="text2">{{num.d}}</text>
                            <div class="block4">
                                <text>{{num.a}}</text>
                                <text>{{num.b}}</text>
                            </div>
                            <div>

                            </div>
                            <div class="divBtn"@click="buttonClick">
                                <image class="imagebutton" src="http://asset.watsons.com.cn/h5/static/images/seckill/1ec560d0375f70ba2ae1f4962.png"></image>
                                <text class="textBtn">马上抢</text>
                            </div>
                        </div>
                    </div>
                </cell>
            </list>
    <!--</div>-->
</template>

<style scoped>
    .textBtn{
        font-size: 30px;
        color: white;
        margin-top: 10px;

    }
    .imagebutton{
        position: absolute;
        width: 400px;
        height: 60px;
    }
    .divBtn{
        width: 400px;
        height: 60px;
        /*flex-direction: column;*/
        /*justify-content: center;*/
        align-items: center;
        background-color: aqua;
    }
    .home2{
        background-color: #66548b;

    }
    .top1image{
        width: 750px;
        height: 204px;
    }
    .top2image{
        width: 750px;
        height: 342px;
    }
    .mainimage{
        width: 180px;
        height: 245px;
        /*width: ;*/
    }
    .list2{
        background-color: #66548b;
        /*justify-content: flex-end;*/


    }

    .text2{
        width: 400px;
        margin-top: 10px;
        font-size: 26px;
    }

    .cell {
        background-color: aquamarine;
        width: 690px;
        margin-left: 30px;
        margin-top: -30px;

    }
    .block{
        background-color: #fefbf3;
        height: 300px;
        width: 690px;
        /*border: #d3acac;*/
        flex-direction: row;
        border-left-width: 10px;
        border-right-width: 10px;
        border-left-color: #d37d50;
        border-right-color: #d37d50;
        justify-content: space-between;
        align-items: center;
        padding: 30px;
        /*border-bottom-color: RGBA(0,0,0,0)*/
        /*border-bottom-width: 0px;*/


    }
    .block2{
        justify-content: center;
        align-items: center;
        width: 180px;
        height: 245px;
        background-color: white;
    }
    .block3{

        /*justify-content: space-between;*/

    }
        /*justify-content: flex-end;*/
    /*}*/
    .block4{
        margin-top: 10px;
        flex-direction: row;
        justify-content: space-between;

    }

</style>

<script>
    import {Card} from './includes'
    const modal = weex.requireModule('modal')
    export default {
        components:{ 'card':Card },
        data() {
            return {
                name: "card",
                title: "card info",
                info: "2014-11-20过期",
                backsrc: "../res/card.png",
                lists:[],//[{a:"¥68",b:"200/4999",c:"日常喷一喷 脸蛋不泛红",d:"S.A.白金舒润冰川水保湿喷雾80毫升",}, {a:"¥68",b:"200/4999"}, {a:"¥68",b:"200/4999"}, {a:"¥68",b:"200/4999"}, {a:"¥68",b:"200/4999"}],
            }
        },
        mounted(){
            var list = []

            for (var n = 0; n < 10;n++){
                var obj = new Object()
                obj.a = "¥68";
                obj.b = "200/4999";
                obj.c = "日常喷一喷 脸蛋不泛红";
                obj.d = "S.A.白金舒润冰川水保湿喷雾80毫升";
                this.lists.push(obj);
            }
        },

        computed: {
            newList () {

                var list = []

                for (var n = 0; n < 10;n++){
                    var obj = new Object()
                    obj.a = "¥68";
                    obj.b = "200/4999";
                    obj.c = "日常喷一喷 脸蛋不泛红";
                    obj.d = "S.A.白金舒润冰川水保湿喷雾80毫升";
                    list.push(obj);
                }

                return list;
                }

            },
        methods: {
            update: function (e) {
                this.title = "click" + this.title

            },
            buttonClick:function (e) {
                modal.toast({ message: 'buttonClick', duration: 0.1 })
                var nav = weex.requireModule('event2')
                nav.openPage("watsons-protocol://item/?uid=11_9514&stockCode=")
            },
            fetch(e) {
                modal.toast({ message: 'load more', duration: 0.1 })

                setTimeout(() => {
                    var list = []

                    for (var n = 0; n < 10;n++){
                        var obj = new Object()
                        obj.a = "¥68";
                        obj.b = "200/4999";
                        obj.c = "日常喷一喷 脸蛋不泛红";
                        obj.d = "S.A.白金舒润冰川水保湿喷雾80毫升";
                        this.lists.push(obj);
                    }
                }, 500)
            },

        }
    }
</script>