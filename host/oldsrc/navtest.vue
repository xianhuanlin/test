<template>
    <div class="home">

        <div class="button" @click="update">
            <text @click="update">{{title}}</text>
        </div>

    </div>
</template>

<style scoped>

    .button{
        /*position: absolute;*/
        /*margin-top: 120px;*/
        border: antiquewhite;
        border-radius: 5;
        border-width: 1;
        background-color: aquamarine;

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
    const animation = weex.requireModule('animation')
    var nav = weex.requireModule('event2')
    const clipboard = weex.requireModule('clipboard')
    import util from '../src/util.js'
    var isok = false
    export default {
        components: {},
        data() {
            return {
                name: "card",
                title: "点击跳转",
                title2: "点我一下",
                info: "2014-11-20过期",
                backsrc: "../res/card.png",
            }
        },
        mounted(){
            this.title = "mounted"
        },
        methods: {
            update: function (e) {

                navigator.push({
                    url: 'http://10.66.48.126:8081/dist/listtest.js',
                    animated: "true"
                }, event => {
                    //modal.toast({ message: 'callback: ' + event })
                })


            },
            divClick: function (e) {
                var date = new Date()
                e.currentTarget.onClick = null
                this.title2 = date.toUTCString()
                e.currentTarget.onClick = null;
                // e.target.style.opacity = 0.5
                // e.target.style
            },

            move: function (e) {
                var testEl = e.currentTarget; //this.$refs.vvd;
                animation.transition(testEl, {
                    styles: {
                        opacity:0
                        // transform: 'translate(250px, 100px)',
                        // transformOrigin: 'center center'
                    },
                    duration: 800, //ms
                    timingFunction: 'ease',
                    needLayout: false,
                    delay: 0 //ms
                }, function () {
                    modal.toast({message: 'animation finished.'})
                })
            }


        }
    }
</script>