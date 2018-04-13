<template>
    <div style="position: absolute;" @consigneeChange="onConsigneechange" @couponChange="onCoupneChange">
        <scroller class="scroll" v-if="loadingOk" ref="scroll">
            <div class="addressHeader"></div>
            <div class="addressCell" >
                <image class="addressTopImage" src="asset://bg-page-bar"></image>
                <div class="addressContent">
                    <div>
                        <div style="flex-direction: row;justify-content: space-between;width: 660px">
                            <text class="addressUser">收货人:{{}}</text>
                            <text class="addressUser">135900000000</text>
                        </div>

                        <text class="addressInfo normalText">收货地址:</text>
                        <div v-if="0 && showSubAddress">
                            <text class="addressInfoSubInfo">123</text>
                            <text class="addressInfoSubTip">456</text>
                        </div>
                        <text class="addresstips">(收货不方便时，可选择门店自提)</text>

                    </div>
                    <div class="divRight">
                        <image class="moreIcon" src="asset://order-arrow-right"></image>
                    </div>

                    <!--<text class="addressPhone">135900000000</text>-->
                </div>

            </div>

            <div class="itemsCell" v-if="orderSettleModel">
                <div v-for="item in orderSettleModel.item_list">

                    <div class="itemContent">
                        <image class="rowImage" resize="cover" :src="item.icon_url"></image>
                        <div style="position: absolute;left: 175px;top:35px">
                            <text class="rowTitle">{{item.item_name}}</text>
                            <text class="rowInfo">{{item.sku_snapshot[0].values}}</text>
                        </div>
                        <div style="margin-top: 6px">
                            <text class="rowPrice">￥{{parseFloat(item.unit_price)/100}}</text>
                            <text class="rowNum">X{{item.number}}</text>
                        </div>
                    </div>

                    <div style="margin-left: 30px;width:690px;height: 1px;background-color:#dad8d8"></div>
                </div>
            </div>

            <div class="deliverCell" style="margin-top: 20px">
                <div style="flex-direction: row; justify-content: space-between">
                    <text class="titleText">配送方式</text>
                    <div style="flex-direction: row;">
                        <text class="rightTextInfo">普通快递</text>
                        <image class="moreIcon diliverRightIcon" src="asset://order-arrow-right"></image>
                    </div>
                </div>
            </div>
            <div class="divLine"></div>

            <div class="deliverCell">
                <div style="flex-direction: row; justify-content: space-between">
                    <text class="titleText">优惠券</text>
                    <div style="flex-direction: row;">
                        <text class="rightTextInfo"></text>
                        <text class="rightTextInfo">张</text>
                        <image class="moreIcon diliverRightIcon" src="asset://order-arrow-right"></image>
                    </div>
                </div>
            </div>
            <div class="divLine"></div>

            <div class="deliverCell">
                <div style="flex-direction: row; justify-content: space-between">
                    <text class="titleText">积分抵扣</text>
                    <div style="flex-direction: row;">
                        <text class="rightTextInfo">使用积分抵扣</text>
                        <image class="moreIcon diliverRightIcon" src="asset://order-arrow-right"></image>
                    </div>
                </div>
            </div>

            <div class="priceDetailCell">

            </div>

            <div class="vipPointCell">

            </div>

            <div class="invoceCell">

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
    .priceDetailCell{
        padding: 30px;
    }
    .titleText{
        font-size: 30px;
        color: #4a4a4a;
    }
    .divLine{
        margin-left: 30px;
        height: 1px;width: 720px;
        background-color:#dad8d8;
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
    .deliverCell{
        padding-left: 30px;
        padding-top: 30px;
        height: 88px;
        background-color: white;
    }
    .itemContent{
        padding-left: 30px;
        padding-right: 30px;
        padding-top: 30px;
        padding-bottom:30px ;
        flex-direction: row;

        justify-content: space-between;
        background-color: white;
        border-bottom-width: 1px;
        border-bottom-color: #dadad8;
    }
    .rowInfo{
        font-size: 24px;
        color:#919191;
        margin-top: 51px;
    }
    .rowTitle{
        font-size: 26px;
        color: #222222;
    }
    .rowImage{
        width: 120px;
        height: 120px;
    }
    .rowNum{
        margin-top: 5px;
        font-size: 26px;
        color: #919090;
        text-align:right;
    }
    .rowPrice{
        font-size: 30px;
        color: #4a4a4a;
        text-align:right;

    }
    .itemsCell {
        margin-top: 30px;

    }
    .addresstips{
        color: #4CD7C0;
        font-size: 26px;
        margin-top: 20px;
    }


    .divRight{
        justify-content: center;
        align-items:stretch ;
        width: 18px;
    }
    .addressContent{
        flex-direction: row;
        justify-content: space-between;
        padding-left: 30px;
        padding-right: 30px;
        padding-top: 40px;
        padding-bottom: 40px;
    }
    .addressInfo{
        margin-top: 20px;
        max-lines: 2;


    }
    .addressCell {
        background-color: white;
        /*padding: 30px;*/

    }

    .addressTopImage{
        width: 750px;
        height: 10px;

    }

    .normalText{
        color: #4a4a4a;
        font-size: 26px;
    }

    .addressUser{
        /*margin-left: 30px;*/
        /*margin-top: 30px;*/
        color: #4a4a4a;
    }
    .addressPhone{
        position: absolute;
        /*margin-left: 220px;*/
        /*margin-top: 30px;*/
    }

    .moreIcon{
        width: 18px;
        height: 30px;
        /*top:50%;*/
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
                // addressId:-1,
                addressInfo:{},
                couponInfo:{},
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
                navigator.setNavBarTitle({title:"提交订单"},function () {

                })
                // return;
                var ws = this;

                ws.errorInfo.show = false
                ws.loadingOk = false

                if (!this.order_item_list){
                    var pageParams = util.parseUrl(weex.config.bundleUrl);
                    this.order_item_list = pageParams.order_item_list;
                }

                wtsEvent.showLoading('1');
                this.reqParams = this.genPreSubmissParams()
                var method = this.isGroupBuy? "get":"post"
                var path = this.isGroupBuy ? "group/settlement/get/v1":"trade/order/settlement/get"

                wtsEvent.fetch(method,path,this.reqParams,function (rsp) {
                    wtsEvent.showLoading('0')
                    if (rsp == null) {
                        wtsEvent.toast("系统错误");
                        return
                    }

                    if (rsp.code == 10000) {
                        ws.orderSettleModel = rsp.data.settlement_info
                        // ws.itemModel = {order_list:[rsp.data.order]};
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

            //生成预结算接口的信息
            genPreSubmissParams:function () {
                var params = {}

                if (!this.groupBuy){
                    params.order_item_list = this.order_item_list;
                    params.consignee_uid = this.consignee_uid
                    params.auto_select_coupon = 0
                    // params.radix = this.order_item_list[0].radix;
                    // params.sku_id = this.order_item_list[0].sku_id;
                    // params.number = this.order_item_list[0].number;
                }else{
                    params.order_item_list = this.order_item_list;
                    params.consignee_uid = this.consignee_uid
                    params.number = this.order_item_list[0].number;
                    params.radix = this.order_item_list[0].radix;
                    params.sku_id = this.order_item_list[0].sku_id;
                    params.number = this.order_item_list[0].number;
                }
                return params;

            },

            //生成结算接口的信息
            genSubmissParams:function () {
                var params = {}

                if (this.groupBuy){

                }else{

                }

            },
            onCoupneChange:function (params) {

            },
            onConsigneechange:function (params) {
                wtsEvent.toast(params.uid)
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