<template>
    <scroller class="root">
        <div v-if="" class="mainCell">
            <image class="mainImage" :src="imageSet[0].image_url" @click="mainImageClick"></image>
            <text v-if="salePoint.length>0" class="salePoint">{{salePoint}}</text>
            <text class="title">{{title}}</text>

            <div class="divPrice">
                <text class="price">￥</text>
                <text class="price2">{{price}}</text>
                <text class="marketPrice">{{marketPrice}}</text>
            </div>

            <div  class="divDeliver">
                <div class="divDeliverCell" v-for="item in deliverInfo">
                    <image src="asset://icon-detailpage-OK" class="deliverIcon"></image>
                    <text class="deliver">{{item.label_name}}</text>
                </div>
            </div>
        </div>
        <div class="activityCell" v-for="num in activityList">
            <div class="activityItem">
                <image></image>
                <text></text>
                <text></text>
                <image></image>
            </div>
        </div>
        <div class="rulecell">
            <image class="ruleImage" :src="ruleImage"></image>
        </div>
        <div class="sunbianCell">
            <text class="sunbianTitle">笋编说</text>
            <text class="sunbianInfo">{{sunbianInfo}}</text>
        </div>
        <div class="brandCell">
            <text class="brandtitle">品牌</text>
            <image class="brandimage" :src="brandData.image" @click="brandClick"></image>
            <text class="brandname">{{brandData.name}}</text>
            <text class="brandinfo">{{brandData.info}}</text>
        </div>
        <web2 ref="web1" class="webView2" :style='styleWeb' :src="detailUrl" @onPageHeightChange="webHeightChange"></web2>
        <!--<div class="errordiv" ></div>-->
    </scroller>
</template>

<style scoped>
    .errordiv{
        width: 750px;
        height: 750px;

        position: fixed;
        background-color: red;
    ;
    }
    .sunbianCell{
        padding: 30px;
        background-color: white;
        margin-top: 20px;
    }
    .sunbianTitle{
        font-size: 30px;
        color: #4A4A4A;;
    }
    .sunbianInfo{
        font-size: 26px;
        color: #919191;;
        margin-top: 10px;
        /*lines:2;*/
    }
    .brandCell{
        padding: 30px;
        margin-top: 20px;
        background-color: white;
        height: 288px;
    }
    .brandtitle{
        font-size: 30px;
        color: #4a4a4a;
    }
    .brandimage{
        width: 170px;
        height: 170px;
        margin-top: 30px;
        border-width: 2px;
        border-color: #ebe9e9;
        position: absolute;
    }
    .brandname{
        margin-top: 30px;
        margin-left: 200px;
        font-size: 30px;
        font-weight: bold;
        color: #4a4a4a;
        position: absolute;
    }
    .brandinfo{
        margin-top: 80px;
        margin-left: 200px;
        font-size: 26px;
        color: #4a4a4a;
        position: absolute;
        lines:2;
    }

    .activityItem{

    }
    .activityCell{

    }
    .deliver{
        font-size: 26px;
        color: #919191;

    }
    .divDeliverCell{
        flex-direction: row;
    }
    .deliverIcon {
        width: 36px;
        height: 36px;
        margin-right: 6px;
    }

    .divDeliver{
        margin-top: 10px;
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
        position: absolute;
    }

    .mainCell{
        background-color: white;
        flex-direction: column;
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
    .divPrice{
        margin-top: 10px;
        flex-direction: row;
        align-items: flex-end;
        padding-left: 30px;
        padding-right: 30px;
    }
    .price{
        font-size: 26px;
        color: #4A4A4A;
    }
    .price2{
        font-weight: bold;
        font-size: 40px;
        color: #4A4A4A;
        margin-left: 5px;
    }
    .marketPrice{
        font-size: 26px;
        color: #DAD8D8;
        text-decoration:line-through;
        margin-left: 10px;
    }
    .
    .deliver{

    }
</style>

<script>
    const wtsEvent = weex.requireModule('WTSEvent')
    const animation = weex.requireModule('animation')
    import util from './util.js'
    export default {
        components: {},
        data() {
            return {
                imageSet:[{image_url:''}],
                deliverInfo:[],

                title: "card info",
                salePoint:"好卖",

                price:"123",
                marketPrice:"￥130",
                detailUrl:"https://h5.watsons.com.cn/appItem?url=http://asset.watsons.com.cn/d/1286_04a349f7a0b8600b7b60cfbccb5a40ac.html",
                loadingOk:false,
                sunbianInfo:'',
                ruleImage:'',
                activityList:[],
                brandData:{image:'',info:'',},
                styleWeb:{width:'750px',height:'1350px','margin-top':'20px'}

            }
        },
        mounted () {
            this.reloadPage()

        },
        methods: {
            reloadPage:function () {
                var ws = this;
                var params = util.parseUrl(weex.config.bundleUrl)
                wtsEvent.showLoading('1');
                wtsEvent.fetch("get","item/ws/get",{item_uid:params.uid},function (rsp) {
                    wtsEvent.showLoading('0')
                    // wtsEvent.toast("fetch ok");
                    if (rsp == null) {
                        wtsEvent.toast("系统错误");
                        wtsEvent.toast("fetch return");
                        return
                    }
                    if (rsp.code == 10000) {
                        ws.loadingOk = true;
                        // wtsEvent.toast("fetch 10000");
                    } else {
                        wtsEvent.toast('系统错误!');
                        return;
                    }

                    var item = rsp.data.item;
                    ws.title = item.item_long_name;
                    ws.salePoint = item.item_short_name;
                    ws.imageSet = item.item_sku_image_list
                    // wtsEvent.toast(util.deviceHeight().toString());
                    console.log(rsp);
                    ws.price =  parseFloat(item.min_price)/100 + ''
                    // ws.marketPrice = '9999'
                    ws.sunbianInfo = '我是一个笋编说'
                    ws.detailUrl = item.item_menu_list[0].item_desc_url;
                    ws.deliverInfo = item.item_label_list;
                    ws.brandData = {
                        image: item.item_brand.logo,
                        info: item.item_long_name + item.item_long_name,
                        id: item.item_brand.id,
                        name: item.item_brand.brand_name,
                    }
                    //异步加载头部
                    setTimeout(function () {
                        wtsEvent.addTopupButton(100)
                        wtsEvent.addReloadHeader()
                    }, 100)

                    //更新web的高度
                    var id = setInterval(function () {
                        ws.updateHeight()
                    },500)

                    //10秒后停止interval
                    setTimeout(function () {
                        clearInterval(id)
                    }, 10000)

                    const { title,price} = ws
                    ws.price = '1120'
                    wtsEvent.toast(title)
                    wtsEvent.toast(price)
                })
            },
            mainImageClick:function (e) {
                wtsEvent.showFullImage([this.imageSet[0].image_url],0)
            },
            brandClick:function (e) {
                var params = {"itemUId":'11_8354'};
                wtsEvent.openNativePage('WTSItemDetailViewController',params)
            },
            updateHeight:function (e) {
                var ws = this;
                this.$refs.web1.getContainHeight2(function (height) {
                    var newHeight = height + 'px';
                    if (newHeight != ws.styleWeb.height){
                        ws.styleWeb.height = newHeight
                    }

                })

            },
        }
    }
</script>