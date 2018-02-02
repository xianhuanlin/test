<template>
    <div style="position: absolute;background-color: white">
        <scroller class="scroll" v-if="loadingOk" ref="scroll">
            <div v-if="" class="mainCell">
                <div @click="mainImageClick">
                    <image class="mainImage" :src="imageSet[0].image_url" @click="mainImageClick"></image>
                    <div style="opacity: 0.02; background-color: black;width: 750px;height: 750px;position: absolute;top:0;"></div>
                </div>

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

            <div class="rulecell" style="width: 750px;height: 180px;margin-top: 20px;padding: 30px;background-color: white">
                <text class="sunbianTitle">闪电图流程</text>
                <image class="ruleImage" src="asset://icon-groupdetail-rule" style="width: 696px; height: 79px; margin-top: 10px"></image>
            </div>

            <div class="sunbianCell">
                <text class="sunbianTitle">笋编说</text>
                <text class="sunbianInfo">{{brief}}</text>
            </div>

            <div class="brandCell">
                <text class="brandtitle">品牌</text>
                <image class="brandimage" :src="brandData.image" @click="brandClick"></image>
                <text class="brandname">{{brandData.name}}</text>
                <text class="brandinfo">{{brandData.info}}</text>
            </div>
            <div v-if="commentModel.length > 0" style="background-color: white;margin-top: 20px">
                <div class="divCommentCell" v-if="commentModel.length > 0">
                    <div class='commentButton' v-for="item in commentModel" @click="gotoCommentPage(item)">
                        <text style="color:#f55a84;font-size:28px">{{item.tag + '(' + item.num + ')'}}</text>
                    </div>

                </div>
                <div class="divCommentCell2" v-if="latestComment">
                    <div style="flex-direction: row;align-items: center">
                        <image :src="latestComment.user_img_url" class="commentHedad"></image>
                        <text style="font-size: 30px;color: black;margin-left: 10px">{{latestComment.nick_name}}</text>
                    </div>
                    <text style="font-size:28px;color:#4a4a4a;margin-top: 20px">{{latestComment.sku_reviews}}</text>
                </div>
                <div class="gotoCommentCell">
                    <div class="gotoCommentBtn" @click="gotoFullCommentPage">
                        <text style="color: #4a4a4a;font-size: 28px;">{{gotoCommentBtnText}}</text>
                    </div>
                </div>

            </div>

            <web2 ref="web1" class="webView2" :style='styleWeb' :src="detailUrl" @onPageHeightChange="webHeightChange"></web2>

        </scroller>
        <div style="height: 1px;background-color: #4a4a4a;opacity: 0.1" v-if="loadingOk"></div>
        <div class="bottomCell" :style="bottomStyle" v-if="loadingOk">
            <div style="width: 280px;align-items: center;justify-content: center;background-color: white" v-if="isShowLeft" @click="singleBuy">
                <text style="font-size: 36px;color: #4a4a4a">￥{{singleBuyPrice}}</text>
                <text style="font-size: 24px;color: #4a4a4a">(单独买)</text>
            </div>
            <div style="align-items: center;justify-content: center;background-color: #ff6692;flex: 1" @click="groupBuy">
                <text style="font-size: 36px;color: white">￥{{groupBuyPrice}}</text>
                <text style="font-size: 24px;color: white">({{memberCount}}人团)</text>
            </div>
        </div>

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
    .errorButton{
        width: 288px;
        height: 88px;
        background-color: #4CD7C0;
        border-radius: 8px;
        justify-content: center;
        align-items: center;
        margin-top: 10px
    }
    .commentHedad{
        width: 60px;
        height: 60px;
        border-radius: 50%;
    }
    .gotoCommentBtn{
        /*padding: 30px;*/
        border-radius: 50%;
        height: 68px;
        width: 280px;
        border-color: #4a4a4a;
        border-width: 1px;
        justify-content: center;
        align-items: center;
    }
    .gotoCommentCell{
        justify-content: center;
        align-items: center;
        background-color: white;
        padding-bottom: 20px;
    }
    .normaltext{
        font-size: 26px;
        color: #4a4a4a;

    }
    .commentButton{
        background-color:#fbecf0;
        margin-right: 14px;
        /*padding: 26px;*/
        padding-bottom: 10px;
        padding-top:10px;
        padding-right: 26px;
        padding-left: 26px;
        border-radius: 50%;
        margin-bottom: 20px;
    }
    .divCommentCell2 {
        /*flex-direction: row;*/
        background-color: white;
        padding: 30px;
        /*margin-top: 20px;*/
        width: 750px;
        /*flex-wrap: wrap;*/
        /*justify-content: space-around;*/
    }
    .divCommentCell {
        flex-direction: row;
        background-color: white;
        /*padding-top: 30px;*/
        /*padding-left: 30px;*/
        /*padding-right: 0px;*/
        /*padding-bottom: 30px;*/
        padding: 30px;
        padding-right: 0px;
        margin-top: 20px;
        width: 750px;
        flex-wrap: wrap;
        /*justify-content: space-around;*/
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
        margin-top: 25px;
        border-width: 2px;
        border-color: #ebe9e9;
        position: absolute;
    }
    .brandname{
        margin-top: 25px;
        margin-left: 200px;
        font-size: 30px;
        font-weight: bold;
        color: #4a4a4a;
        position: absolute;
    }
    .brandinfo{
        margin-top: 75px;
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
    .scroll{
        flex-direction: column;
        background-color: #f4f4f4;
        flex: 1;
        /*position: absolute;*/
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
        color: #4a4a4a;
        /*text-align: center;*/
    }
    .title{
        font-size: 26px;
        margin-top: 10px;
        padding-left: 30px;
        padding-right: 30px;
        color: #4a4a4a;
    }
    .divPrice{
        margin-top: 10px;
        flex-direction: row;
        align-items: flex-end;
        padding-left: 30px;
        padding-right: 30px;
        color: #4a4a4a;
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
    const modal = weex.requireModule('modal')
    import util from './util.js'
    export default {
        components: {},
        data() {
            return {
                itemModel:null,
                activityModel:null,
                params:null,
                imageSet:[{image_url:''}],
                deliverInfo:[],

                title: " ",
                salePoint:" ",
                brief:' ',
                price:"0",
                marketPrice:"",
                detailUrl:'',
                loadingOk:false,
                ruleImage:'',
                activityList:[],
                brandData:{image:'',info:'',},
                styleWeb:{width:'750px',height:'1350px','margin-top':'20px'},
                isShowLeft:true,
                commentModel:[], //这里只缓存最多10个评论
                gotoCommentBtnText:'查看全部评价  >',
                latestComment:null,
                singleBuyPrice:'',
                groupBuyPrice:'',

                memberCount:'',

                errorInfo:{show:false,info:''}
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
                console.log('weex:ok')
                var ws = this;
                var reqParams = {activity_key:this.activityKey}
                // reqParams.stock_code = '729'
                if (this.groupKey != null && this.groupKey.length > 0){
                    reqParams.group_key = this.groupKey
                }
                if (this.stockCode && this.stockCode.length > 0){
                    reqParams.stock_code = this.stockCode;
                }

                ws.errorInfo.show = false
                ws.loadingOk = false
                wtsEvent.showLoading('1');

                wtsEvent.fetch("get","group/item/detail/get",reqParams,function (rsp) {
                    wtsEvent.showLoading('0')
                    if (rsp == null) {
                        wtsEvent.toast("系统错误");
                        return
                    }

                    if (rsp.code == 10000) {
                        ws.loadingOk = true;
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

                    var item = rsp.data.item_d_t_o;

                    ws.itemModel = item;
                    ws.activityModel = rsp.data.activity_v_o;
                    // ws.params = params;
                    ws.title = item.item_name;
                    ws.salePoint = item.sale_point ? item.sale_point : ''
                    ws.imageSet = item.item_sku_image_d_t_o_list
                    ws.brief = item.item_brief ? item.item_brief : ''
                    // wtsEvent.toast(util.deviceHeight().toString());
                    // console.log(rsp);
                    ws.price =  parseFloat(item.min_price)/100 + ''
                    if (item.max_price > 0 && item.max_price > item.min_price){
                        ws.marketPrice = '￥' + parseFloat(item.max_market_price)/100 + ''
                    }

                    ws.detailUrl = item.item_menu_list[0].item_desc_url;
                    ws.deliverInfo = item.item_label_d_t_o_list;
                    ws.brandData = {
                        image: item.item_brand_d_t_o.logo,
                        info: item.item_brand_d_t_o.brand_desc + item.item_long_name,
                        id: item.item_brand_d_t_o.id,
                        name: item.item_brand_d_t_o.brand_name,
                    }
                    var activityObj = rsp.data.activity_v_o;
                    ws.singleBuyPrice = parseFloat(activityObj.item_original_price) / 100 + ''
                    ws.groupBuyPrice = parseFloat(activityObj.item_price) / 100 + ''
                    ws.isShowLeft = activityObj.normal_buy;
                    ws.memberCount = activityObj.member_count;

                    ws.saveDataToNative()
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
                    }, 10000);

                    setTimeout(function () {
                        ws.loadCommentData()
                    },500);

                    // const { title,price} = ws
                    // // ws.price = '1120'
                    // wtsEvent.toast(title)
                    // wtsEvent.toast(price)
                })
            },
            mainImageClick:function (e) {
                wtsEvent.showFullImage([this.imageSet[0].image_url],0)
            },
            brandClick:function (e) {
                var params = {"brand_id":this.brandData.id,trade_type:this.itemModel.trade_type};
                wtsEvent.openNativePage('WTSHotBrandDetailViewController',params)
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
            loadCommentData:function () {
                var params = {item_id:this.itemModel.item_id,sku_id:0,has_img:0,hot_tag:'',count:10}
                var ws = this;
                wtsEvent.fetch("post","item/reviews/list",params,function (rsp) {
                    if (rsp.code == 10000) {
                         ws.commentModel = rsp.data.hot_tags;
                         // if (rsp.data.reviews.length > 0){
                             ws.latestComment = rsp.data.reviews[0];
                         // }
                    }

                })
            },
            gotoCommentPage:function (e) {
                var index = this.commentModel.indexOf(e)
                var params = {itemid:this.itemModel.item_id,tagIndex:index};
                wtsEvent.openNativePage('WTSDetailCommentViewController',params)

            },
            gotoFullCommentPage:function () {
                var params = {itemid:this.itemModel.item_id};
                wtsEvent.openNativePage('WTSDetailCommentViewController',params)
            },
            singleBuy:function () {
                wtsEvent.umengReport('10246')
                var params = {"itemUId":this.itemModel.item_uid};
                wtsEvent.openNativePage('WTSItemDetailViewController',params)
            },
            groupBuy:function () {
                // var item = this.itemModel;
                // var act = this.activityModel;
                // var params = {SKUID:item.act.sku_id,itemUID:item.item_uid,radix:act.radix,tradeType:item.trade_type,
                //     itemType:item.item_type}
                //
                wtsEvent.umengReport('10247')
                var ws = this;
                this.checkStock(function (ret) {
                    if (ret){
                        wtsEvent.postEvent('onGroupBuy',{})
                    }
                })

            },
            checkStock:function (ret) {
                var ws = this;
                var item = this.activityModel;

                var reqParams = {activity_key:this.activityKey
                  ,number:1,item_id:item.item_id, sku_id:item.sku_id,radix:item.radix};
                if (item.stock_code){
                    reqParams.stock_code = item.stock_code
                }

                // modal.toast({message: util.formatObj(reqParams)})
                // return
                wtsEvent.fetch("get","group/settlement/get/v1",reqParams,function (rsp) {
                  if (rsp.code == 10000){
                      ret(true)
                  }else{
                      ret(false)
                      wtsEvent.toast(rsp.msg)
                  }
                })

            },
            saveDataToNative:function () {
                var item = this.itemModel;
                var act = this.activityModel;

                var params = {sku_id:act.sku_id,item_uid:item.item_uid,radix:act.radix,trade_type:item.trade_type,
                    item_type:item.item_type,price:item.item_price};

                    //这几个比较可能缺少所以一个个赋值
                params.short_name = item.item_short_name;
                params.long_ame= item.item_long_name;
                params.image= this.imageSet[0].image_url;
                params.share_url=item.share_url;
                params.sale_point=item.sale_point;

                wtsEvent.postEvent('onPageLoadingOk',params)
            },
            reloadClick:function () {
                this.reloadPage()
            }
        }
    }
</script>