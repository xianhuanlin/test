<template>
    <div style="position: absolute;" @consigneeChange="onConsigneechange" @couponChange="onCoupneChange" @nativeNotify="onNativeNotification">
        <scroller class="scroll" v-if="loadingOk" ref="scroll">
            <div class="addressHeader"></div>
            <div class="addressCell" v-if="addressInfo">
                <image class="addressTopImage" src="asset://bg-page-bar"></image>
                <div class="addressContent">
                    <div>
                        <div style="flex-direction: row;justify-content: space-between;width: 630px">
                            <text class="addressUser">收货人:{{addressInfo.consignee}}</text>
                            <text class="addressUser">{{addressInfo.mobile}}</text>
                        </div>

                        <text class="addressInfo normalText">收货地址:{{addressInfo.detailInfo}}</text>
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
            <listCell :itemListModel="listModel" :packListModel="packModel">

            </listCell>
            <div class="orderCommonCell" style="margin-top: 20px">
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
            <div class="divLine"></div>

            <div class="orderCommonCell">
                <div style="flex-direction: row; justify-content: space-between">
                    <text class="titleText">优惠券</text>
                    <div style="flex-direction: row;">
                        <text class="priceText">{{orderSettleModel.coupon_amount}}</text>
                        <text class="rightTextInfo">张可用</text>
                        <image class="moreIcon diliverRightIcon" src="asset://order-arrow-right"></image>
                    </div>
                </div>
            </div>
            <div class="divLine"></div>

            <div class="orderCommonCell">
                <div style="flex-direction: row; justify-content: space-between">
                    <text class="titleText">积分抵扣</text>
                    <div style="flex-direction: row;">
                        <text class="rightTextInfo">使用积分抵扣</text>
                        <image class="moreIcon diliverRightIcon" src="asset://order-arrow-right"></image>
                    </div>
                </div>
            </div>

            <div class="priceDetailCell" v-if="orderSettleModel">
                <div v-for="detail in orderSettleModel.price_detail">
                    <div class="divRow" style="margin-bottom: 20px">
                        <text :style="priceDetailStyle(detail,0)">{{detail.title}}</text>
                        <div class="divRow">
                            <text style="background-color: #f4f4f4;color: #4a4a4a;font-size: 22px;margin-right: 10px;padding-top: 5px" v-if="detail.tag">{{detail.tag}}</text>
                            <text :style="priceDetailStyle(detail,1)">{{detail.content}}</text>
                        </div>
                    </div>
                </div>

                <div class="divLine2"></div>
                <div class="cellAmount">
                    <text class="titleText">合计</text>
                    <text class="priceText">{{safePrice(orderSettleModel.total_amount)}}</text>
                </div>

            </div>

            <div class="orderCommonCell" style="margin-top: 20px">
                <div style="flex-direction: row; justify-content: space-between">
                    <text class="titleText">会员卡积分</text>
                    <div style="flex-direction: row;">
                        <text class="rightTextInfo">使用积分抵扣</text>
                        <image class="moreIcon diliverRightIcon" src="asset://order-arrow-right"></image>
                    </div>
                </div>

            </div>

            <div class="orderCommonCell" style="margin-top: 20px" @click="onInvoiceClick">
                <div style="flex-direction: row; justify-content: space-between">
                    <text class="titleText">发票</text>
                    <div style="flex-direction: row;">
                        <text class="rightTextInfo">{{invoiceText}}</text>
                        <image class="moreIcon diliverRightIcon" src="asset://order-arrow-right"></image>
                    </div>
                </div>
            </div>

            <div class="iphonXDiv" v-if="isIphoneX"></div>
        </scroller>
        <div v-if="loadingOk" class="bottomCell">
            <div class="divPay">
                <text class="titleText">应付金额:</text>
                <text class="priceText">{{safePrice(orderSettleModel.total_amount)}}</text>
            </div>
            <div style="background-color:#4cd7c0;justify-content: center;align-items: center;width: 240px">
                <text style="color: white;font-size: 30px;">去支付</text>
            </div>

        </div>
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
    .divPay{
        padding-left: 30px;
        flex-direction: row;
        width: 510px;
        background-color: white;
        align-items: center;border-color: #d8d8d8;border-top-width: 1px;
    }
    .bottomCell{
        height: 88px;
        flex-direction: row;
    }
    .cellAmount{
        /*height: 70px;*/
        padding-top: 30px;
        background-color: white;
        flex-direction: row;

        justify-content: space-between;

    }
    .divRow{
        flex-direction: row;
        justify-content: space-between;
    }
    .priceDetailCell{
        padding: 30px;
        background-color: white;
        margin-top: 20px;
    }
    .priceText{
        font-size: 36px;
        color: #ff6692;
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
    .divLine2{
        margin-left: 0px;
        height: 2px;
        width: 690px;
        border-top-width: 2px;
        border-top-color: #c7c4c4;
        border-top-style: dashed;
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
    .orderCommonCell{
        padding-left: 30px;
        padding-top: 22px;
        height: 88px;
        background-color: white;
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
    import itemlistCell from './orderSubmissCells/orderItemCell.vue'
    // import {listCell} from './vueTypes'
    // import {listCell,detail} from './vueTypes'

    const wtsEvent = weex.requireModule('WTSEvent')
    const animation = weex.requireModule('animation')
    const modal = weex.requireModule('modal')
    const navigator = weex.requireModule('navigator')


    const WTSNewOrderEventAddress = "WTSNewOrderEventAddress";
    const WTSNewOrderEventCoupon = "WTSNewOrderEventCoupon";
    const WTSNewOrderEventDelevery = "WTSNewOrderEventDelevery";

    //会员卡积分
    const WTSNewOrderEventVipPoint = "WTSNewOrderEventVipPoint";

    //积分抵扣
    const WTSNewOrderEventMemberPoint = "WTSNewOrderEventMemberPoint";
    const WTSNewOrderEventInvoice = "WTSNewOrderEventInvoice";

    import util from './util.js'
    export default {
        components: {'listCell':itemlistCell},
        data() {
            return {
                orderSettleModel:null,

                //当前的地址信息
                addressInfo:null,
                invoiceObj:null,

                couponInfo:null,
                //当前的发票信息,
                curInvoiceInfo:null,
                itemModel:null, //这里存的是一个order列表，兼容后面可能会有多个门店的订单的情况
                loadingOk:false,
                errorInfo:{show:false,info:'系统错误'},
                reqParams:{offset:0,count:1},
                showSubAddress:true,
            }
        },
        mounted () {
            this.requestAddressInfo(function (isOk,rsp) {

            })

        },
        computed: {
            isIphoneX(){
                return util.isIPhoneX()
            },
            invoiceText(){
                if (!this.invoiceObj){
                    return "不开发票";
                }else{
                    var type = this.invoiceObj.invoice_type == 1 ? '个人' : '单位'

                    if (this.invoiceObj.invoice_type == 1 && this.addressInfo.consignee){
                        return this.addressInfo.consignee + ' (' + type + ')'
                    }else if (this.invoiceObj.invoice_type == 2 ){

                    }
                }

            },
            listModel(){
                if (this.orderSettleModel){
                    return this.orderSettleModel.item_list;
                }
                else{
                    return null;
                }
            },
            packModel(){
                if (this.orderSettleModel){
                    return this.orderSettleModel.package_list;
                }
                else{
                    return null;
                }
            },

            deliverType(){

            },

        },

        methods: {
            tagStyle:function(tagInfo){
                return {'background-color':tagInfo['bg_color'],'border-radius':'4px'}
            },
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

                    // ws.saveDataToNative()
                    //异步加载头部
                    setTimeout(function () {
                        wtsEvent.addTopupButton(100)
                    }, 100)

                })
            },

            addressFromJson:function (json) {
                var addr = ''
                if (json.province){
                    addr += json.province
                }
                if (json.city){
                    addr += json.city
                }
                if (json.area){
                    addr += json.area
                }
                if (json.address){
                    addr += json.address
                }
                return addr
            },

            requestAddressInfo:function (cb) {
                //闪电购流程比较特殊

                if (this.order_item_list[0].trade_type == 3 && this.appStockCode.length > 0){

                }else{
                    var ws = this;
                    wtsEvent.showLoading('1')
                    wtsEvent.fetch('get','user/consignee/list',{},function (rsp) {
                        if (rsp.code == 10000){
                            wtsEvent.showLoading('0')
                            if (rsp.data.consignee_list.length > 0){
                                var consigneeObj = rsp.data.consignee_list[0]
                                var info = {}
                                info.detailInfo = ws.addressFromJson(consigneeObj)
                                info.consignee = consigneeObj.consignee
                                info.mobile = consigneeObj.mobile
                                info.consignee_uid = consigneeObj.consignee_uid

                                ws.onConsigneechange(info)
                            }
                            else{
                                cb(true,null)
                                wtsEvent.showLoading('0')
                            }
                        }else{
                             cb(false,null)
                            wtsEvent.showLoading('0')
                        }


                    })
                }
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
                this.addressInfo = params;
                this.reloadPage()
            },
            gotoPay:function (params) {


            },
            //积分抵扣改变
            onVipPointDikouChange:function (params) {

            },
            //使用会员卡积分
            onVipPointChange:function (params) {

            },
            //修改发票
            onInvoceChange:function (params) {
                this.invoiceObj = params;
            },

            //native来的通知
            onNativeNotification:function (nativeInfo) {
                var eventName = nativeInfo.eventName;
                console.log(eventName)
                var router = {WTSNewOrderEventInvoice:this.onInvoceChange}
                if (router[eventName]){
                    router[eventName](nativeInfo)
                }
            },

            postEventToNative:function (name,params) {
                var userInfo = {event:name,params:params}
                wtsEvent.postEvent('onPageNotify',userInfo)
            },
            onInvoiceClick:function (e) {
                this.postEventToNative(WTSNewOrderEventInvoice,this.invoiceObj)

            },
            safePrice:function (price) {
                if (!price){
                    return ' '
                }

                return '￥' + parseFloat(price)/100
            },
            priceDetailStyle:function (detail,isContent) {
                if (isContent){
                    return {'color':detail.content_color,'font-size':'30px'}
                }
                else{
                    return {'color':detail.title_color,'font-size':'30px'}
                }

            },
        }
    }
</script>