<template>
    <scroller class="root">
        <div v-if="" class="mainCell">
            <image class="mainImage" :src="imageSet[0]"></image>
            <text v-if="salePoint.length>0" class="salePoint">{{price}}</text>
            <text class="title">{{title}}</text>

            <div class="divPrice">
                <text class="price">1</text>
                <text class="price2">2</text>
                <text class="marketPrice">3</text>
            </div>
            <div  class="divDeliver">
                <div class="divDeliverCell">
                    <image src="asset://icon-detailpage-OK" class="deliverIcon"></image>
                    <text class="deliver">123</text>
                </div>
                <div class="divDeliverCell">
                    <image src="asset://icon-detailpage-OK" class="deliverIcon"></image>
                    <text class="deliver">123</text>
                </div>
                <div class="divDeliverCell">
                    <image src="asset://icon-detailpage-OK" class="deliverIcon"></image>
                    <text class="deliver">123</text>
                </div>
            </div>

        </div>
        <web class="webView" :src="detailUrl"></web>
    </scroller>
</template>

<style scoped>
    .deliver{
        width: auto;
        height: 30px;
        font-size: 30px;
        background-color: red;
    }
    .divDeliverCell{
        flex-direction: row;
    }
    .deliverIcon {
        width: 36px;
        height: 36px;
    }

    .divDeliver{
        height: 74px;
        flex-direction: row;
        padding-left: 30px;
        padding-right: 30px;
        justify-content: space-between;
        background-color: #fafafa;
        align-items: center;
    }
    .root{
        flex-direction: column;
        background-color: #f4f4f4;
    }
    .webView{
        /*margin-top: 1000px;*/
        width: 750px;
        height: 1750px;
        margin-top: 20px;
    }

    .mainCell{
        background-color: white;
        flex-direction: column;
    }
    .divPrice{
        /*margin-top: ;*/
        flex-direction: row;
        /*justify-content: space-between;*/
    }
    .mainImage{
        width: 750px;
        height: 750px;
    }
    .salePoint{
        font-weight: bold;
        font-size: 32px;
        margin-top: 10px;
        padding-left: 30px;
        padding-right: 30px;
        /*text-align: center;*/
    }
    .title{
        font-size: 26px;
        margin-top: 10px;
        padding-left: 30px;
        padding-right: 30px;
    }
    .price{
        font-size: 26px;
        color: #4A4A4A;
        margin-top: 10px;
        padding-left: 30px;
        padding-right: 30px;
    }
    .price2{
        font-weight: bold;
        font-size: 40px;
        margin-top: 10px;
        padding-left: 30px;
        padding-right: 30px;
        color: #DAD8D8;
    }
    .marketPrice{
        font-size: 26px;
        color: #DAD8D8;
        text-decoration:line-through;
    }
    .
    .deliver{

    }
</style>

<script>
    const wtsEvent = weex.requireModule('WTSEvent')
    const animation = weex.requireModule('animation')

    export default {
        components: {},
        data() {
            return {
                imageSet:['http://image.watsons.com.cn//upload/7a34638a.jpg?x-oss-process=image/indexcrop,y_400,i_1/format,webp/interlace,1/quality,Q_70',],
                deliverInfo:['七天包换','七天包换'],


                title: "card info",
                salePoint:"好卖",

                price:"123",
                marketPrice:"112",
                detailUrl:"https://h5.watsons.com.cn/appItem?url=http://asset.watsons.com.cn/d/1286_04a349f7a0b8600b7b60cfbccb5a40ac.html",
                loadingOk:false,


            }
        },
        mounted () {
            var ws = this;
            wtsEvent.showLoading('1');
            wtsEvent.fetch("get","item/ws/get",{item_uid:"11_8354"},function (rsp) {
                wtsEvent.showLoading('0')

                if (rsp == null) {
                    wtsEvent.toast("系统错误");
                    return
                }
                if (rsp.code == 10000){
                    this.loadingOk = true;
                }else{
                    wtsEvent.toast('系统错误!');
                    return;
                }

                wtsEvent.toast("fetch ok");
                var item = rsp.data.item;
                // this.title = item.item_long_name;
                wtsEvent.toast(item.item_long_name);
                console.log(rsp);
            })
        },
        methods: {
            update: function (e) {
                this.title = "click" + this.title

            }
        }
    }
</script>