<template>
    <div>
        <slider class="slider" interval="4500" @change="onchange">
            <div class="frame" v-for="img in imageList">
                <image class="image" resize="cover" :src="img.src"></image>
                <text class="title">{{img.title}}</text>
            </div>
            <indicator v-if="imageList.length > 1" class="indicator"></indicator>
        </slider>
    </div>
</template>

<style>
    .image {
        width: 750px;
        height: 750px;
    }
    .slider {
        /*margin-top: 25px;*/
        /*margin-left: 25px;*/
        width: 750px;
        height: 750px;
        /*border-width: 2px;*/
        /*border-style: solid;*/
        /*border-color: #41B883;*/
    }
    .title {
        position: absolute;
        top: 20px;
        left: 20px;
        padding-left: 20px;
        width: 200px;
        color: #FFFFFF;
        font-size: 36px;
        line-height: 60px;
        background-color: rgba(0, 0, 0, 0.3);
    }
    .frame {
        width: 750px;
        height: 750px;
        position: relative;
    }
    .indicator {
        width: 750px;
        height: 750px;
        item-color: green;
        item-selected-color: red;
        item-size: 14px;
        position: absolute;
        top: 280px;
        left: 0px;
    }
</style>

<script>
    export default {
        data () {
            return {
                imageList: [
                    { title: 'item A', src: 'https://gd2.alicdn.com/bao/uploaded/i2/T14H1LFwBcXXXXXXXX_!!0-item_pic.jpg'},
                    // { title: 'item B', src: 'https://gd1.alicdn.com/bao/uploaded/i1/TB1PXJCJFXXXXciXFXXXXXXXXXX_!!0-item_pic.jpg'},
                    // { title: 'item C', src: 'https://gd3.alicdn.com/bao/uploaded/i3/TB1x6hYLXXXXXazXVXXXXXXXXXX_!!0-item_pic.jpg'}
                ]
            }
        },
        methods: {
            onchange (event) {
                console.log('changed:', event.index)

            }
        }
    }
</script>