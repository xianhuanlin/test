<template>
    <div class="orderCommonCell" style="margin-top: 20px" v-if="deliverModel">
        <div style="flex-direction: row; justify-content: space-between">
            <text class="titleText">配送方式</text>
            <div style="flex-direction: row;">
                <text class="rightTextInfo">普通快递</text>
                <image class="moreIcon diliverRightIcon" src="asset://order-arrow-right"></image>
            </div>
        </div>
        <div v-if="1">

        </div>
    </div>
</template>

<style scoped>
    .titleText{
        font-size: 30px;
        color: #4a4a4a;
    }
    .diliverRightIcon{
        margin-top: 6px;
        margin-right: 30px;
    }
    .rightTextInfo{
        font-size: 30px;
        color: #919090;
        margin-right: 30px;

    }
    .moreIcon{
        width: 18px;
        height: 30px;
    }
</style>

<script>
    export default {
        props: {
            deliverModel: {
                type: Object,
                default: null,
            },


        },
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
                this.title = "click" + this.title

            }
        }
    }
</script>