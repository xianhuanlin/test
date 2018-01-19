<template>
    <div>
        <div class="button2">
            <div class="div2" @click="move">

            </div>
            <div class="div2" @click="move">

            </div>
            <div class="div2" @click="move">

            </div>
            <div ref="vvd" class="div2" @click="divClick">
                <text>{{title2}}</text>
            </div>
        </div>

    </div>
</template>

<style scoped>
    .div2{
        width: 150px;
        height: 150px;
        background-color: bisque;
        border-radius: 8px;

        /*margin-left: 30px;*/
        /*position: absolute;*/
        /*margin-right: 10px;*/
        align-items: center;
        justify-content: center;
    }

    .button2{
        background-color: red;
        /*position: absolute;*/
        /*margin-top: 100px;*/

        width: 750px;
        height: 280px;
        flex-direction: row;
        justify-content: space-around;

        align-items: center;
    }


</style>

<script>
    var navigator = weex.requireModule('navigator')
    var modal = weex.requireModule('modal')
    const animation = weex.requireModule('animation')
    // var nav = weex.requireModule('event2222')
    const clipboard = weex.requireModule('clipboard')
    import util from './util.js'
    var temp = undefined
    export default {
        components: {},
        data() {
            return {
                name: "card",
                title: "card info",
                title2: "card info",
                info: "2014-11-20过期",
                backsrc: "../res/card.png",
            }
        },
        methods: {
            update: function (e) {
                this.title = "click" + this.title

            },
            divClick: function (e) {
                var date = new Date()
                e.currentTarget.onClick = null
                this.title2 = date.toUTCString()
                e.currentTarget.onClick = null;
                // e.target.style.opacity = 0.5
                // e.target.style
            },

            rotate:function (e,f) {
                animation.transition(testEl, {
                    styles: {
                        // opacity:0,
                        transform: 'rotateY(30)',
                        needLayout:true,
                        // transform: 'translate(250px, 100px)',
                        // transformOrigin: 'center center'
                    },
                    duration: 300, //ms
                    timingFunction: 'linear',
                    needLayout: true,
                    delay: 0 //ms
                }, function () {
                    f();
                })
            },
            rotate2:function (e) {
                temp = e;
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
                var testEl = this.$refs.vvd;
                this.rotate2(testEl);
            }
        }
    }
</script>