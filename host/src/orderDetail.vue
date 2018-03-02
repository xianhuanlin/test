<template>
    <div style="position: absolute;background-color: white">
        <scroller class="scroll" v-if="loadingOk" ref="scroll">
            <div v-for="item in itemModel.order_list" >
                <div style="margin-top: 30px" class="orderSection">
                <div class="orderHeader">
                    <image resize="cover" src="asset://sc-cardHeader"style="left: 0; position: absolute;width:720px;height: 54px"></image>
                    <text class="shopName">订单号:{{item.order_sn}}</text>
                    <!--<text class="orderDate">{{item.order_time}}</text>-->
                </div>
                <div v-for="subItem in item.order_item_list" class="orderRow">
                    <div class="orderContent">
                        <image class="rowImage" :src="subItem.icon_url" @click="imageClick(subItem)" ></image>
                        <div style="position: absolute;left: 200px;">
                            <text class="rowTitle">{{subItem.item_name}}</text>
                            <text class="rowInfo">{{subItem.sku_spec_list[0].values}}</text>
                        </div>
                        <div style="margin-top: 30px;">
                            <text class="roworgPrice">￥{{parseFloat(subItem.price)/100}}</text>
                            <text class="rowPrice">￥{{parseFloat(subItem.price)/100}}</text>
                            <text class="rowNum">X{{subItem.number}}</text>
                        </div>
                    </div>
                </div>
                <div style="margin-top: -20px">
                    <image class="separator" src="asset://sc-cardBlock"></image>
                </div>
                <div class="orderFooter">
                    <div>
                        <div style="flex-direction: row;align-items:flex-start">
                            <text class="detailText">支付流水号：</text>
                            <text class="detailText detailText2">{{item.order_payment.out_trade_no}}</text>
                        </div>

                        <text class="detailText">支付方式：{{item.order_payment.pay_type}}</text>
                        <text class="detailText">支付时间：{{item.order_time}}</text>
                    </div>
                    <div style="flex-direction: row;align-items: center;">
                        <text class="normalText">实付:</text>
                        <text class="amount">￥{{calcPrice(item.total_amount)}}</text>
                    </div>

                </div>
                <div style="height: 1px;background-color: #dadad8"></div>
                <div class="bottom">
                    <div class="bottomButton" @click="onCheckOrderClick(item)">
                        <image src="asset://sc-order" class="buttonImage"></image>
                        <text class="normalText">查看小票</text>
                    </div>

                    <!--<div style="width: 1px;background-color: #dadad8"></div>-->
                    <!--<div class="bottomButton" @click="onTaxClick(item)">-->
                        <!--<image src="asset://sc-tax"  class="buttonImage"></image>-->
                        <!--<text class="normalText">查看电子发票</text>-->
                    <!--</div>-->
                </div>
            </div>
        </div>

        </scroller>
        <div v-if="errorInfo.show"  style="align-items:center;margin-top: 300px;justify-content: center">
            <image src="asset://icon-all-net" style="width: 220px;height: 220px"></image>
            <text style="margin-top: 10px;color: #919191;">{{errorInfo.info}}</text>
            <div class="errorButton" @click="reloadClick">
                <text style="color: white;font-size: 32px;">重新加载</text>
            </div>
        </div>

    </div>

</template>

<style scoped>
    .buttonText{

    }
    .buttonImage{
        width: 24px;
        height: 24px;
        margin-right: 10px;
    }
    .bottomButton{
        flex-direction: row;
        justify-content: center;
        align-items: center;
        flex: 1;
    }
    .detailText{
        font-size: 22px;
        color: #9c9a9c;

        text-overflow:ellipsis;

    }
    .detailText2{
        width: 280px;
        lines:2;
        text-align: left;
        font-size: 22px;
        margin-top: 2px;
    }
    .separator {
        width: 710px;
        height: 98px ;
    }

    .bottom{
        background-color: white;
        flex-direction: row;
        height: 88px;
        /*flex: 1;*/
        /*justify-content: space-between;*/

    }
    .normalText{
        color: #4a4a4a;
        font-size: 26px;
    }
    .amount{
        /*margin-right: 20px;*/
        color: #ff6692;
        font-size: 40px;
        margin-left: 5px;
        /*background-color: #4a4a4a;*/
    }
    .discount{
        /*text-align: center;*/
        margin-right: 30px;
        font-size: 26px;
        color: #4a4a4a;
        /*background-color: greenyellow;*/
    }
    .orderDate{
        font-size: 30px;
        color: white;
    }
    .shopName{
        font-size: 26px;
        color: white;
    }
    .rowNum{
        margin-top: 10px;
        font-size: 26px;
        color: #919090;
        text-align:right;
    }
    .roworgPrice{
        font-size: 30px;
        color: #DAD8D8;
        text-decoration:line-through;
        /*margin-left: 10px;*/
    }
    .rowPrice{
        font-size: 32px;
        color: #ff6692;
        text-align:right;
    }
    .rowInfo{
        margin-top: 10px;
        font-size: 24px;
        color: #919090;
    }
    .rowTitle{
        margin-top: 10px;
        width: 300px;
        /*height: ;*/
        lines:2;
        font-size: 26px;
        color: #4a4a4a;
    }
    .rowImage{
        height: 150px;
        width: 170px;
    }
    .orderFooter{
        background-color: white;
        flex-direction: row;
        justify-content: space-between;
        /*align-items: center;*/
        /*height: 120px;*/
        /*border-bottom-width: 1px;*/
        /*border-bottom-color: #dadad8;*/
        padding-left: 30px;
        padding-right: 30px;
        /*padding-top: 40px;*/
        padding-bottom: 40px;
        /*background-color: #0088fb;*/
    }

    .orderHeader{
        background-color: #4CD7C0;
        flex-direction: row;
        justify-content: space-between;
        padding-left: 30px;
        padding-right: 30px;
        height: 60px;
        align-items: center;

    }
    .orderSection{
        border-radius: 20px;
        /*background-color: white;*/
        overflow: hidden;
        width: 710px;
        margin-left: 20px;
        margin-top: 20px;
        /*padding: 30px;*/

    }
    .orderContent {
        flex-direction: row;
        padding-top: 30px;
        /*padding-bottom: 30px;*/
        border-bottom-width: 1px;
        border-bottom-color: #dadad8;
        height: 200px;
        justify-content: space-between;
        /*align-items: center;*/
    }
    .orderRow{
        /*background-color: red;*/
        padding-left: 30px;
        padding-right: 30px;
        background-color: white;
        /*padding: 30px;*/

    }
    .errorButton{
        width: 288px;
        height: 88px;
        background-color: #4CD7C0;
        border-radius: 8px;
        justify-content: center;
        align-items: center;
        margin-top: 10px;
    }

    .scroll{
        flex-direction: column;
        background-color: #f4f4f4;
        /*justify-content: center;*/
        flex: 1;
    }


</style>

<script>
    const wtsEvent = weex.requireModule('WTSEvent')
    const animation = weex.requireModule('animation')
    const modal = weex.requireModule('modal')
    const navigator = weex.requireModule('navigator')
    // const CryptoJS = require("crypto-js/md5");
    import util from './util.js'
    export default {
        components: {},
        data() {
            return {
                itemModel:null, //这里存的是一个order列表，兼容后面可能会有多个门店的订单的情况
                loadingOk:false,
                errorInfo:{show:false,info:'系统错误'},
                reqParams:{offset:0,count:1}
            }
        },
        mounted () {
            this.reloadPage()

        },
        computed: {
            bottomStyle(){
                return {height:'128px',width:'750px','flex-direction':'row'}
            },
            // price(e){
            //     var pricef = parseFloat(e)/100;
            //     return pricef.toString()
            // },


        },

        methods: {
            calcPrice:function(e){
                var pricef = parseFloat(e)/100;
                return pricef.toString()
            },
            reloadPage:function () {
                var ws = this;
                // wtsEvent.toast(new Date().getTime().toString())
                // wtsEvent.toast(weex.config.bundleUrl)

                ws.errorInfo.show = false
                ws.loadingOk = false
                // var pageParams = new Object()
                if (!this.order_uid){
                    var pageParams = util.parseUrl(weex.config.bundleUrl);
                    this.order_uid = pageParams.order_uid;
                }

                wtsEvent.showLoading('1');

                // if (pageParams.order_uid == undefined){
                //     this.order_uid = '11_379_1151694'
                //     pageParams.order_uid = this.order_uid;
                // }

                this.reqParams = {order_uid:this.order_uid}
                wtsEvent.fetch("get","trade/order/get",this.reqParams,function (rsp) {
                    wtsEvent.showLoading('0')
                    if (rsp == null) {
                        wtsEvent.toast("系统错误");
                        return
                    }

                    if (rsp.code == 10000) {
                        ws.itemModel = {order_list:[rsp.data.order]};
                        ws.loadingOk = true;
                        ws.errorInfo.show = false;
                        // wtsEvent.toast("fetch 10000");
                    } else {
                        if (rsp.msg){
                            wtsEvent.toast(rsp.msg);
                        }

                        if (rsp.code == -1009){
                            ws.errorInfo.info = '网络不太顺畅喔~'
                        }else{
                            ws.errorInfo.info = '系统错误'
                        }

                        ws.errorInfo.show = true
                        return;
                    }

                    // wtsEvent.toast(rsp.data.total_count + '')
                    // var item = rsp.data.order_list;
                    // ws.reqParams.offset = item.length;
                    //ws.itemModel = item;

                    ws.saveDataToNative()
                    //异步加载头部
                    setTimeout(function () {
                        wtsEvent.addTopupButton(100)
                        // wtsEvent.addReloadHeader()
                    }, 100)
                    navigator.setNavBarTitle({title:"订单详情"},function () {

                    })
                    if (!ws.isReport){
                        wtsEvent.wtsViewReport('Scan_go_order_details',ws.order_uid)
                        ws.isReport = true
                    }


                    //更新web的高度
                    // var id = setInterval(function () {
                    //
                    // },500)
                    //
                    // //10秒后停止interval
                    // setTimeout(function () {
                    //     clearInterval(id)
                    // }, 10000);
                    //
                    // setTimeout(function () {
                    //
                    // },500);

                })
            },
            orderClick:function(item){
                wtsEvent.toast('ok')
            },
            saveDataToNative:function () {
                // var item = this.itemModel;
                // var act = this.activityModel;
                //
                // var params = {sku_id:act.sku_id,item_uid:item.item_uid,radix:act.radix,trade_type:item.trade_type,
                //     item_type:item.item_type,price:item.item_price};
                //
                // //这几个比较可能缺少所以一个个赋值
                // params.short_name = item.item_short_name;
                // params.long_ame= item.item_long_name;
                // params.image= this.imageSet[0].image_url;
                // params.share_url=item.share_url;
                // params.sale_point=item.sale_point;
                // params.sku_uid = 11 + '_' + act.sku_id
                // wtsEvent.postEvent('onPageLoadingOk',params)
            },
            reloadClick:function () {
                this.reloadPage()
            },
            fetchMore:function () {
                var ws = this;
                // wtsEvent.toast('loadMore')
                wtsEvent.showLoading('1')

                wtsEvent.fetch("get","trade/order/list",this.reqParams,function (rsp) {
                    wtsEvent.showLoading('0')
                    if (rsp == null) {
                        wtsEvent.toast("系统错误");
                        return
                    }

                    if (rsp.code == 10000) {
                    } else {
                        return;
                    }

                    var itemMore = rsp.data.order_list;
                    var length = itemMore.length;
                    var itemList = ws.itemModel.order_list;
                    for (var t = 0 ; t < length; t++){
                        itemList.push(rsp.data.order_list[t])
                    }
                    ws.reqParams.offset += itemMore.length;
                    // wtsEvent.toast(rsp.data.order_list.length + '')
                });

            },
            onCheckOrderClick:function (item) {
                wtsEvent.openPage(item.electronic_ticket_url)
                wtsEvent.umengReport('10270')
            },
            onTaxClick:function (item) {
                wtsEvent.openPage(item.got_invoice_url)
            },
            imageClick:function (e) {
                 wtsEvent.showFullImage([e.icon_url],0)
            },
            payType:function (payId) {
                if (payId == 1 || payId == 11){
                    return '支付宝支付'
                }else if (payId == 2){
                    return '微信支付'
                }
                else {
                    return 'unknown'
                }
            },
            payTime:function (timeStamp) {

            }

        }
    }
</script>