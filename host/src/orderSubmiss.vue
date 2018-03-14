<template>
    <div style="position: absolute;">
        <scroller class="scroll" v-if="loadingOk" ref="scroll">
            <div class="addressHeader"></div>
            <div class="address">
                <image class="addressTopImage" src="asset://bg-page-bar"></image>
                <div class="addressContent">
                    <div>
                        <text class="addressUser">收货人{{}}</text>
                        <text class="addressInfo"></text>
                        <div v-if="showSubAddress">
                            <text class="addressInfoSubInfo"></text>
                            <text class="addressInfoSubTip"></text>
                        </div>

                    </div>
                    <image class="moreIcon" src="asset://order-arrow-right"></image>
                    <text class="addressPhone"></text>
                </div>

            </div>

            <div class="itemList">
                <div v-for="item in orderSettleModel.package_list">

                    <div class="orderContent">
                        <image class="rowImage" resize="cover" :src="subItem.icon_url"></image>
                        <div style="position: absolute;left: 200px;top:30px;">
                            <text class="rowTitle">{{subItem.item_name}}</text>
                            <text class="rowInfo">{{subItem.sku_spec_list[0].values}}</text>
                        </div>
                        <div style="margin-top: 6px">
                            <text class="roworgPrice" v-if="subItem.delete_price && subItem.delete_price > subItem.price">{{safePrice(subItem.delete_price)}}</text>
                            <text class="rowPrice" v-if="!(subItem.delete_price && subItem.delete_price > subItem.price)">{{safePrice(subItem.delete_price2)}}</text>
                            <text class="rowPrice">￥{{parseFloat(subItem.price)/100}}</text>
                            <text class="rowNum">X{{subItem.number}}</text>
                        </div>
                    </div>



                </div>

            </div>

            <div class="coupon">

            </div>

            <div class="pointExchange">

            </div>

            <div class="deliver">

            </div>

            <div class="priceDetail">

            </div>

            <div class="vipPoint">

            </div>
            <div class="invo">

            </div>
            <div class="iphonXDiv" v-if="isIphoneX"></div>
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
    .addressContent{
        flex-direction: row;
        justify-content: space-between;
    }
    .addressInfo{
        margin-top: 34px;

    }
    .address {
        background-color: white;
        /*padding: 30px;*/

    }

    .addressTopImage{
        width: 750px;
        height: 10px;

    }

    .normalText{

    }

    .addressUser{
        margin-left: 30px;
        margin-top: 30px;
    }
    .addressPhone{
        position: absolute;
        margin-left: 220px;
        margin-top: 30px;
    }

    .moreIcon{

    }

    .iphonXDiv{
        height: 72px;
        background-color: #f4f4f4;
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
        flex: 1;
    }


</style>

<script>
    const wtsEvent = weex.requireModule('WTSEvent')
    const animation = weex.requireModule('animation')
    const modal = weex.requireModule('modal')
    const navigator = weex.requireModule('navigator')

    import util from './util.js'
    export default {
        components: {},
        data() {
            return {
                orderSettleModel:null,
                
                itemModel:null, //这里存的是一个order列表，兼容后面可能会有多个门店的订单的情况
                loadingOk:false,
                errorInfo:{show:false,info:'系统错误'},
                reqParams:{offset:0,count:1},
                showSubAddress:true,
            }
        },
        mounted () {
            this.reloadPage()

        },
        computed: {
            bottomStyle(){
                return {height:'128px',width:'750px','flex-direction':'row'}
            },
            isIphoneX(){
                return util.isIPhoneX()
            },


        },

        methods: {
            calcPrice:function(e){
                var pricef = parseFloat(e)/100;
                return pricef.toString()
            },
            reloadPage:function () {
                this.loadingOk = true;
                console.log('wxxx')
                console.log(this.order_item_list.length)
                navigator.setNavBarTitle({title:"提交订单"},function () {

                })
                return;
                var ws = this;

                ws.errorInfo.show = false
                ws.loadingOk = false

                if (!this.order_uid){
                    var pageParams = util.parseUrl(weex.config.bundleUrl);
                    this.order_uid = pageParams.order_uid;
                }

                wtsEvent.showLoading('1');
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

                    ws.saveDataToNative()
                    //异步加载头部
                    setTimeout(function () {
                        wtsEvent.addTopupButton(100)
                    }, 100)

                    navigator.setNavBarTitle({title:"提交订单"},function () {

                    })
                })
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

            onCheckOrderClick:function (item) {
                wtsEvent.openPage(item.electronic_ticket_url)
                wtsEvent.umengReport('10270')
            },
            safePrice:function (price) {
                if (!price){
                    return ' '
                }

                return '￥' + parseFloat(price)/100
            }

        }
    }
</script>