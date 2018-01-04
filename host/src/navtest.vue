<template>
    <div class="home">
        <div class="button" @click="update">
            <text @click="update">{{title}}</text>
        </div>

    </div>
</template>

<style scoped>
    .button{
        border: antiquewhite;
        border-radius: 5;
        border-width: 1;
        background-color: darkseagreen;

        justify-content: center;
        align-items: center;
        height: 300px;
        width: 300px;
    }

    .home{
        justify-content: center;
        align-items: center;
    }


</style>

<script>
    var navigator = weex.requireModule('navigator')
    var modal = weex.requireModule('modal')
    //var modal2 = weex.requireModule('modaldetail')
   // var nav = weex.requireModule('event2222')
    const clipboard = weex.requireModule('clipboard')
    import util from './util.js'

    export default {
        components: {},
        data() {
            return {
                name: "card",
                title: "card info",
                info: "2014-11-20过期",
                backsrc: "../res/card.png",
            }
        },
        methods: {
            update: function (e) {
                // clipboard.getString(ret => {
                //     //this.message = 'text from clipboard:' + ret.data
                //     this.title = ret.data;
                // })
                // return;
                //this.title = "clicked";
                // weex.a = "hello 1"
                // modal.toast({ message: weex.a })
                // try{
                //     this.title = nav.getversion()
                //
                // }catch(e) {
                //
                // }
                // modal.toast({ message:nav.toString()})
                // return
                // util.verSign = "1.2.1"

                // navigator.setNavBarTitle({title:"list"},function () {
                //
                // })
                navigator.push({
                    url: 'http://10.66.48.126:8081/dist/listtest.js',
                    animated: "true"
                }, event => {
                        //modal.toast({ message: 'callback: ' + event })
                })



            }
        }
    }
</script>