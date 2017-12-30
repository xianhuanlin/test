<template>

        <div class="wrapper" @click="update">
            <image :src="logoUrl" class="logo"></image>
            <text class="title">Hello {{target}}</text>
            <text class="desc">Now, let's use vue to build your weex app.</text>

        </div>

</template>

<style>
  .wrapper { align-items: center; margin-top: 120px; background-color: antiquewhite}
  .title { padding-top:40px; padding-bottom: 40px; font-size: 48px; }
  .logo { width: 360px; height: 156px; }
  .desc { padding-top: 20px; color:#888; font-size: 24px;}
  /*.home.js{*/
      /*background-color: aqua;*/
  /*}*/
</style>

<script>
    import util from './util.js'

  export default {
    data: {
      logoUrl: '../res/00.png',
      target: 'xuemei'
    },
    methods: {
      update: function (e) {
            var ret = util.test(11,23)
            console.log('target:', this.target)
            this.target = ret.toString()

      }
    }
  }
</script>