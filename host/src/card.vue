<template>
    <div  class="card-nav" @click="update">
        <div class="card-dev2">
            <image class="image1" :src="backsrc" @click="update">
            </image>
            <text class="title">{{title}}</text>
            <text class="info">{{info}}</text>
        </div>

    </div>
</template>

<style scoped>
    .card-dev2{
        height: 297px;
        width: 453px;
        background-color: red;
        /*flex: 1;*/
    }

    .image1{
        position: absolute;

        height: 297px;
        width: 453px;

    }
    .title {

        margin-left: 30px;
        margin-top: 50px;
        font-size: 48px;
        color: white;
        position: absolute;
    }
    .info{
        margin-left: 30px;
        margin-top: 130px;
        font-size: 30px;
        color: white;
        position: absolute;
    }
    .card-nav{
        height: 327px;
        width: 750px;
        /*justify-items: center;*/
        justify-content: center;
        align-items: center;

        /*position: absolute;*/

    }


</style>

<script>
    export default {
        components: {},
        data () {
            return {
                name: "card",
                title: "card info",
                info: "2014-11-20过期",
                backsrc: "../res/card.png",
            }
        },
        methods: {
            update: function (e) {
                this.title =  "click" + this.title

            }
        }
    }
</script>