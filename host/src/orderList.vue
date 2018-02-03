<template>
    <div style="position: absolute;background-color: white">
        <scroller class="scroll" v-if="loadingOk" ref="scroll">
            <div style="padding: 30px;background-color: gray;">
                <div v-for="item in itemModel.order_list" class="orderSection">

                        <div class="orderHeader">
                            <image resize="cover" src="../res/card.png2" style="left: 0; position: absolute;width:720px;height: 54px"></image>
                            <tex>123</tex>
                            <text>123</text>
                        </div>


                    <!--<div>-->
                        <div v-for="subItem in item.order_item_list" class="orderRow">
                            <div style="">
                                <image></image>
                                <text>1</text>
                                <text>2</text>
                                <text>3</text>
                                <text>4</text>
                            </div>
                        </div>
                    <!--</div>-->

                    <div class="orderFooter">
                        <text style="margin-right: 30px;font-size: 26px;color: #4a4a4a;">1</text>
                        <text style="margin-right: 20px;color: #ff6692;font-size: 30px">2</text>
                    </div>

                </div>
            </div>
        </scroller>

        <div v-if="errorInfo.show" style="align-items:center;margin-top: 300px;">
            <image src="asset://icon-all-net" style="width: 220px;height: 220px"></image>
            <text style="margin-top: 10px;color: #919191;">{{errorInfo.info}}</text>
            <div class="errorButton" @click="reloadClick">
                <text style="color: white;font-size: 32px;">重新加载</text>
            </div>
        </div>
    </div>

</template>

<style scoped>
    .orderFooter{
        background-color: white;
        flex-direction: row;
        justify-content: flex-end;
        align-items: center;
        height: 88px;
    }

    .orderHeader{
        background-color: #4CD7C0;
        flex-direction: row;
        justify-content: space-between;
        padding-left: 30px;
        padding-right: 30px;
        height: 54px;
        align-items: center;

    }
    .orderSection{
        /*padding: 30px;*/
        border-radius: 20px;
        background-color: white;
        margin-bottom: 20px;
        overflow: hidden;

    }
    .orderCntent {
        padding: 30px;background-color: green;
    }
    .orderRow{
        background-color: #afddff;
        height: 206px;
        padding-left: 30px;
        padding-right: 30px;
        border-bottom-width: 1;
        border-bottom-color: dadad8;
    }
    .errorButton{
        width: 288px;
        height: 88px;
        background-color: #4CD7C0;
        border-radius: 8px;
        justify-content: center;
        align-items: center;
        margin-top: 10px
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
    import util from './util.js'
    export default {
        components: {},
        data() {
            return {
                itemModel:null,
                loadingOk:false,
                errorInfo:{show:false,info:'系统错误'},
                reqParams:{offset:0,count:20}
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
            reloadPage:function () {
                var ws = this;

                ws.errorInfo.show = false
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

                    wtsEvent.toast(rsp.data.total_count + '')
                    var item = rsp.data.order_list;

                    //ws.itemModel = item;

                    ws.saveDataToNative()
                    //异步加载头部
                    setTimeout(function () {
                        wtsEvent.addTopupButton(100)
                        wtsEvent.addReloadHeader()
                    }, 100)

                    //更新web的高度
                    var id = setInterval(function () {

                    },500)

                    //10秒后停止interval
                    setTimeout(function () {
                        clearInterval(id)
                    }, 10000);

                    setTimeout(function () {

                    },500);

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
            fetchMore:function () {

            },
        }
    }
</script>