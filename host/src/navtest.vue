<template>
    <div>
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
        height: 100px;
        width: 750px;
    }

</style>

<script>
    var navigator = weex.requireModule('navigator')
    var modal = weex.requireModule('modal')


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
                this.title = "clicked";

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