<template>
    <div class="itemsCell" v-if="itemListModel">
        <div v-for="item in itemListModel" v-if="!isGrobalStyle && itemListModel">
            <div class="itemContent">
                <image class="rowImage" resize="cover" :src="item.icon_url"></image>
                <div style="position: absolute;left: 175px;top:35px">
                    <div style="flex-direction: row;flex-wrap: wrap;">
                        <text class="rowTitle">{{item.item_name}}</text>
                    </div>
                    <text class="rowInfo">{{item.sku_snapshot[0].values}}</text>

                </div>
                <div style="margin-top: 6px">
                    <div :style="tagStyle(item.tag_info[0])" v-if="item.tag_info.length">
                        <text style="color: white;font-size: 24px;">{{item.tag}}</text>
                    </div>
                    <text class="rowPrice" v-if="item.tag_info.length == 0 || !item.tag_info">￥{{parseFloat(item.unit_price)/100}}</text>
                    <text class="rowNum">X{{item.number}}</text>

                </div>
            </div>
            <!--<div class="divLine2"></div>-->
            <div style="margin-left: 30px;width:690px;height: 1px;background-color:#dad8d8"></div>
        </div>

        <div v-for="pack in packListModel" v-if="isGrobalStyle && packListModel">
            <div style="flex-direction: row;padding: 30px;background-color: white;align-items: center">
                <image style="width: 36px;height: 24px" src="asset://order_submission_icon_box"></image>
                <text class="packTitle">{{pack.name}}</text>
            </div>
            <div style="margin-left: 30px;width:690px;height: 1px;background-color:#dad8d8"></div>
            <div v-for="item in pack.item_list">
                <div class="itemContent">
                    <image class="rowImage" resize="cover" :src="item.icon_url"></image>
                    <div style="position: absolute;left: 175px;top:35px">
                        <div style="flex-direction: row;flex-wrap: wrap;">
                            <text class="rowTitle">{{item.item_name}}</text>
                        </div>
                        <text class="rowInfo">{{item.sku_snapshot[0].values}}</text>

                    </div>
                    <div style="margin-top: 6px">
                        <div :style="tagStyle(item.tag_info[0])" v-if="item.tag_info.length">
                            <text style="color: white;font-size: 24px;">{{item.tag}}</text>
                        </div>
                        <text class="rowPrice" v-if="item.tag_info.length == 0 || !item.tag_info">￥{{parseFloat(item.unit_price)/100}}</text>
                        <text class="rowNum">X{{item.number}}</text>

                    </div>
                </div>
                <div style="margin-left: 30px;width:690px;height: 1px;background-color:#dad8d8" v-if="showLine(item,pack.item_list)"></div>

            </div>

            <div class="divLine2" ></div>
            <div style="flex-direction: row;padding: 30px; justify-content: flex-end;background-color: white">
                <text class="packFeeInfo">运费:{{safePrice(pack.delivery_fee)}}</text>
                <text class="packFeeInfo" style="margin-left: 60px;">税费:{{safePrice(pack.tax_fee)}}</text>


            </div>
        </div>


    </div>
</template>

<style scoped>


    .itemContent{
        padding-left: 30px;
        padding-right: 30px;
        padding-top: 30px;
        padding-bottom:30px ;
        flex-direction: row;

        justify-content: space-between;
        background-color: white;
        /*border-bottom-width: 1px;*/
        /*border-bottom-color: #dadad8;*/
    }
    .packFeeInfo{
        font-size: 24px;
        color:#919191;

    }

    .rowInfo{
        font-size: 24px;
        color:#919191;
        top: 80px;
        position: absolute;
    }
    .packTitle{
        font-size: 26px;
        color: #222222;
        /*max-lines: 2;*/
        left: 10px;
    }
    .rowTitle{
        font-size: 26px;
        color: #222222;
        /*max-lines: 2;*/
        width: 440px;
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
    .divLine2{
        margin-left: 30px;
        height: 2px;
        width: 690px;
        border-top-width: 2px;
        border-top-color: #c7c4c4;
        border-top-style: dashed;
    }
</style>

<script>
    export default {
        props: {
            itemListModel: {
                type: Object,
                default: null,
            },
            packListModel: {
                type: Object,
                default: null,
            },

        },
        components: {},
        data() {
            return {
                name: "card",
            }
        },
        computed: {
            isGrobalStyle(){
                if (this.itemListModel[0].trade_type == 2){
                    return true
                }else{
                    return false
                }

            },
        },
        methods: {
            update: function (e) {
                this.title = "click" + this.title

            },
            tagStyle:function(tagInfo){
                return {'background-color':tagInfo['bg_color'],'border-radius':'4px'}
            },
            calcPrice:function(e){
                var pricef = parseFloat(e)/100;
                return pricef.toString()
            },
            safePrice:function (price) {
                if (typeof(price) == undefined){
                    return ' '
                }
                else if (price == 0){
                    return '￥0'
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
            showLine:function (item,list) {
                if (list.indexOf(item) == list.length - 1)
                    return false

                return true
            },
        }
    }
</script>