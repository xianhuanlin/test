<template>
    <div style="position: absolute;background-color: white">
        <list class="scroll" v-if="loadingOk && !emptyShow" ref="scroll" loadmoreoffset="10" @loadmore="fetchMore">
            <!--<div style="padding: 30px;background-color: gray;">-->
                <cell v-for="item in itemModel.order_list" >
                    <div style="margin-top: 30px" class="orderSection" @click="orderClick(item)">
                        <div class="orderHeader">
                            <image resize="cover" src="asset://sc-cardHeader" style="left: 0; position: absolute;width:720px;height: 60px"></image>
                            <text class="shopName">店铺:{{item.store_name}}</text>
                            <text class="orderDate">{{timeForamt(item.pay_time_long)}}</text>
                        </div>
                        <div v-for="subItem in item.order_item_list" class="orderRow">
                            <div class="orderContent">
                                <image class="rowImage" resize="cover" :src="subItem.icon_url" @click="imageClick(subItem)"></image>
                                <div style="position: absolute;left: 200px;top:40px;">
                                    <text class="rowTitle">{{subItem.item_name}}</text>
                                    <text class="rowInfo">{{subItem.sku_spec_list[0].values}}</text>
                                </div>
                                <div>
                                    <text class="roworgPrice" v-if="subItem.delete_price">{{safePrice(subItem.price2)}}</text>
                                    <text class="rowPrice" v-if="!subItem.delete_price">{{safePrice(subItem.price2)}}</text>
                                    <text class="rowPrice">￥{{parseFloat(subItem.price)/100}}</text>
                                    <text class="rowNum">X{{subItem.number}}</text>
                                </div>
                            </div>
                        </div>
                        <!--</div>-->

                        <div class="orderFooter">
                            <!--<text class="discount">优惠:￥{{calcPrice(item.discount_amount)}}</text>-->
                            <text class="amount">实付:￥{{calcPrice(item.total_amount)}}</text>
                        </div>
                    </div>

                    <!--<div style="height: 20px;width: 690px;background-color: transparent"></div>-->
                </cell>

        </list>
        <div v-if="errorInfo.show"  style="align-items:center;margin-top: 300px;justify-content: center">
            <image src="asset://icon-all-net" style="width: 220px;height: 220px"></image>
            <text style="margin-top: 10px;color: #919191;">{{errorInfo.info}}</text>
            <div class="errorButton" @click="reloadClick">
                <text style="color: white;font-size: 32px;">重新加载</text>
            </div>
        </div>
        <div v-if="emptyShow"  style="align-items:center;margin-top: 300px;;flex: 1;background-color: white">
            <image src="asset://sc-order-empty" style="width: 220px;height: 220px"></image>
            <text style="margin-top: 10px;color: #919191;">暂无相关订单</text>
        </div>
    </div>

</template>

<style scoped>
    .amount{
        margin-right: 20px;
        color: #ff6692;
        font-size: 30px;
        font-weight: bold;
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
        font-size: 30px;
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
        width: 150px;
    }
    .orderFooter{
        background-color: white;
        flex-direction: row;
        justify-content: flex-end;
        align-items: center;
        height: 88px;
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
        background-color: white;
        overflow: hidden;
        width: 690px;
        margin-left: 30px;
        margin-top: 30px;
        /*padding: 30px;*/

    }
    .orderContent {
        flex-direction: row;
        padding-top: 34px;
        /*padding-bottom: 30px;*/
        border-bottom-width: 1px;
        border-bottom-color: #dadad8;
        height: 208px;
        justify-content: space-between;
        /*align-items: center;*/
    }
    .orderRow{
        /*background-color: red;*/
        padding-left: 30px;
        padding-right: 30px;
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
        justify-content: center;
        flex: 1;
    }


</style>

<script>
    const wtsEvent = weex.requireModule('WTSEvent')
    const animation = weex.requireModule('animation')
    const navigator = weex.requireModule('navigator')
    const modal = weex.requireModule('modal')
    import util from './util.js'
    export default {
        components: {},
        data() {
            return {
                itemModel:null,
                loadingOk:false,
                errorInfo:{show:false,info:'系统错误'},
                emptyShow:false,
                reqParams:{offset:0,count:20,type:20}
            }
        },
        mounted () {
            this.reloadPage()

        },
        computed: {
            bottomStyle(){
                return {height:'128px',width:'750px','flex-direction':'row'}
            },
        },

        methods: {
            calcPrice:function(e){
                var pricef = parseFloat(e)/100;
                return pricef.toString()
            },
            reloadPage:function () {
                var ws = this;

                // ws.errorInfo.show = false
                ws.emptyShow = false
                ws.loadingOk = false
                wtsEvent.showLoading('1');

                wtsEvent.fetch("get","trade/order/list",this.reqParams,function (rsp) {
                    wtsEvent.showLoading('0')
                    if (rsp == null) {
                        wtsEvent.toast("系统错误");
                        return
                    }

                    if (rsp.code == 10000) {
                        ws.itemModel = rsp.data;
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
                    navigator.setNavBarTitle({title:"订单列表"},function () {

                    })

                    var item = rsp.data.order_list;
                    ws.emptyShow = (!item || item.length == 0);
                    ws.reqParams.offset = item.length;
                    //ws.itemModel = item;
                    // ws.emptyShow = (!item || item.length == 0);
                    ws.saveDataToNative()
                    //异步加载头部
                    setTimeout(function () {
                        wtsEvent.addTopupButton(100)
                        // wtsEvent.addReloadHeader()
                    }, 100)


                })
            },
            orderClick:function(item){
                const toUrl = weex.config.bundleUrl.split('/').slice(0, -1).join('/') + '/' + 'orderDetail' + '.js'
                console.log(toUrl)
                navigator.push({
                    url: toUrl + '?order_uid=' + item.order_uid,
                    animated: "true"
                }, event => {
                    //modal.toast({ message: 'callback: ' + event })
                })
                // wtsEvent.toast(item.order_uid)
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
            imageClick:function (e) {
                wtsEvent.showFullImage([e.icon_url],0)
            },
            timeForamt:function (e) {
                // e.toString()
                if (!e){
                    return ''
                }
                return util.formatStamp(e,'YYYY MM dd')
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