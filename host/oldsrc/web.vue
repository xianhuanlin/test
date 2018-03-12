<template>
    <scroller @viewappear="viewApear">
        <div>
            <web2 @pagefinish="pageStart" ref="web" :style="style3" enableScroll="1" src="https://h5.watsons.com.cn/appItem?url=http://asset.watsons.com.cn/d/1286_04a349f7a0b8600b7b60cfbccb5a40ac.html" ></web2>
        </div>

    </scroller>
    <!--<scroller @viewappear="viewApear">-->
        <!--<div ref="ss" :style= "style4" width="375px" @click="click2">-->

        <!--</div>-->
        <!--<div ref="ss2" class="webvew" width="375px" @click="click2">-->

        <!--</div>-->
    <!--</scroller>-->


</template>

<style scoped>
    .webvew{
        background-color: #afddff;
        width: 750px;
        height: 750px;
    }


</style>

<script>
    const modal = weex.requireModule('modal')
    const wtsEvent = weex.requireModule('WTSEvent')
    const animation = weex.requireModule('animation')
    export default {


        components: {},
        data() {
            return {
                name: "card",
                title: "card info",
                info: "2014-11-20过期",
                backsrc: "../res/card.png",
                height:750,
                width:750,
                style3:{
                    'width': "750px",
                    'height': "1750px",
                    "background-color": 'aqua',
                },
                // style4:{
                //     width: width + 'px',
                //     height: height + 'px',
                //     "background-color": 'red',
                // },

            }
        },
        computed: {
            loadingStyle () {
                return {
                    'height': `750px`,
                    'width': `1350px`,
                    'background-color':"red"
                }
            }
        },
        methods: {
            update: function (e) {
                this.title = "click" + this.title

            },
            updateHeight:function () {

            },
            pageStart:function (e) {
                // wtsEvent.toast("pageStart")
                // e.back = "1"
                // wtsEvent.toast(e.url)
            },
            viewApear:function (e) {
                wtsEvent.toast("viewAppear")
                wtsEvent.fetch("get","item/ws/get",{item_uid:"11_8354"},function (object) {
                    if (object == null){
                        wtsEvent.toast("错误一大堆")
                    }

                    wtsEvent.toast("fetch ok")
                    var item = object.data.item
                     wtsEvent.toast(item.item_long_name)
                    console.log(object)
                })
                var temp = this;

                // setTimeout(function () {
                //     wtsEvent.toast("ok")
                //     // temp.style4.height = "375px"
                //     wtsEvent.toast("ok2")
                // },3000)
            },
            click2:function (e) {
                 // this.rotate2(this.$refs.ss)
                this.style4.width = "375px"
                //this.$refs.ss.style.height = "1300px"
            },
            rotate2:function (e) {
                // var temp = e;
                animation.transition(e, {
                    styles: {
                        // opacity:0,
                        transform: 'rotate(30)' ,
                        needLayout:true,
                        // transform: 'translate(250px, 100px)',
                        // transformOrigin: 'center center'
                    },
                    duration: 1000, //ms
                    timingFunction: 'ease',
                    needLayout: true,
                    delay: 0 //ms
                }, function () {
                    modal.toast({ message: 'finish', duration: 0.5 })
                    this.rotate2(temp)
                })
            },
            move: function (e) {
                var testEl = this.$refs.ss;
                this.rotate2(testEl);
            }
        }
    }
</script>