<template>
        <scroller class="home">
            <!--<link-->
            <!--<div class="nav">-->

            <!--</div>-->

            <div class="wrapper" @click="update">
                <div>
                    <image :src="logoUrl" class="logo"></image>
                </div>

                <text class="title">Hello {{target}}</text>
                <text class="desc">Now, let's use vue to build your weex app.</text>

            </div>
            <!--<div class="edit">-->
                <!--<textarea></textarea>-->
            <!--</div>-->
            <div class="nav1">
                <div class="image1"></div>
            </div>
            <image class="img1" src="/res/00.png" resize="cover"></image>
            <image class="img1" src="/res/01-02.jpg" resize="cover"></image>
            <image class="img1" src="/res/03.png" resize="cover"></image>
            <float-button>

            </float-button>
            <!--<div class="nav2">-->

            <!--</div>-->
            <!--<float-button :show="show"-->
                         <!--duration="300"-->
                         <!--:hasAnimation="hasAnimation"-->
                         <!--:timingFunction="timingFunction"-->
                         <!--@wxcOverlayBodyClicked="wxcOverlayBodyClicked"-->
                         <!--opacity="0.6"></float-button>-->
        </scroller>


</template>

<style>
  .wrapper {align-items: center; margin-top: 120px; background-color: antiquewhite}
  .title { padding-top:40px; padding-bottom: 40px; font-size: 48px; }
  /*.logo { width: 360px; height: 156px; }*/

  .desc { padding-top: 20px; color:#888; font-size: 24px;}
  .home{
      background-color: white;
      position: absolute;
      /*background-image: url(/res/00.png);*/
  }
  .nav1{
      /*position:fixed;*/
      /*margin-left: 30px;*/
      /*margin-top: 100px;*/
      height: 100px;
      /*width: 40px;*/
      background-color: transparent;
      /*flex: 0;*/
      position: absolute;

      display: none;

  }
  .nav2{

      margin-left: 30px;
      margin-top: 30px;
      width: 40px;
      height: 40px;
      background-color: red;
      position: fixed;
  }
  .image1{
      position:absolute;
      margin-left: 30px;
      margin-top: 30px;
      height: 40px;
      width: 40px;
      background-color: red;
      /*flex: 0;*/
  }

    .nav{
        flex:1;
        background-color: rebeccapurple;
        /*height: 100px;*/
        /*width: 1080px;*/
    }
    .edit{
        height: 300px;
        background-color: white;
        flex: 1;
    }
    .img1{
        height:750px;
        width:750px;
    }
  .img{
      flex: 1;
      height: 300px;
  }


</style>

<script>

    import util from '../src/util.js'
//    import {WxcOverlay} from './includes'
//    import { WxcOverlay } from 'weex-ui/packages/wxc-overlay';
//    import WxcOverlay from 'weex-ui/packages/wxc-overlay';
    import {FloatButton} from './includes'
    export default {
        components: { FloatButton },
    data: {
        logoUrl: '../res/00.png',
        logoUrl2: '../res/00.png',
      target: 'xuemei 2',
        show:false,
    },
    methods: {
      update: function (e) {
            var ret = util.test(11,23)
//            console.log('target:', this.target)
            this.target = ret.toString()
//          window.document.body.style.backgroundColor = "red"
//            this$.$getConfig().evn.width
          this.show = true

      }
    }
  }
</script>