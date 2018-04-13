<template>
    <div style="position: absolute;" @consigneeChange="onConsigneechange" @couponChange="onCoupneChange">
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

            <div class="priceDetailCell" v-if="orderSettleModel">
                <div v-for="detail in orderSettleModel.price_detail">
                    <div class="divRow" style="margin-bottom: 20px">
                        <text :style="priceDetailStyle(detail,0)">{{detail.title}}</text>
                        <div class="divRow">
                            <text style="background-color: #f4f4f4;color: #4a4a4a;font-size: 22px;margin-top: 3px;margin-right: 10px" v-if="detail.tag">{{detail.tag}}</text>
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

            <div class="deliverCell" style="margin-top: 20px">
                <div style="flex-direction: row; justify-content: space-between">
                    <text class="titleText">会员卡积分</text>
                    <div style="flex-direction: row;">
                        <text class="rightTextInfo">使用积分抵扣</text>
                        <image class="moreIcon diliverRightIcon" src="asset://order-arrow-right"></image>
                    </div>
                </div>

            </div>

            <div class="deliverCell" style="margin-top: 20px">
                <div style="flex-direction: row; justify-content: space-between">
                    <text class="titleText">发票</text>
                    <div style="flex-direction: row;">
                        <text class="rightTextInfo">未选择</text>
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
    .deliverCell{
        padding-left: 30px;
        padding-top: 22px;
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
        margin-top: 10px;
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
        margin-top: 20px;

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
                addressInfo:null,
                couponInfo:{},
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
                this.addressInfo = params;
                this.reloadPage()
            },

            //积分抵扣改变
            onVipPointDikouChange:function (params) {

            },
            //使用会员卡积分
            onVipPointChange:function (params) {

            },
            //修改发票
            onInvoceChange:function (params) {

            },
            //native来的通知
            onNativeNotification:function (nativeInfo) {


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