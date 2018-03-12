<template>
    <div>

        <wxc-button class="button1" text="Open Popup"
                    @wxcButtonClicked="buttonClicked">

        </wxc-button>
        <wxc-button class="button1" text="Open Popup" @wxcButtonClicked="buttonClicked" v-if="hidden1">
        </wxc-button>
        <div class="div1"></div>
        <wxc-popup width=750
                   pos="right"
                    ref = "pop2"
                   :show="isShow"
                   @wxcPopupOverlayClicked="overlayClicked">
            <wxc-button class="button1" text="Open Popup"
                        @wxcButtonClicked="buttonClicked3">
            </wxc-button>
        </wxc-popup>
        <div class="div2">
`
        </div>
    </div>
</template>
<style>
    .button1{
        /*flex: 1;*/
        width: 250px;
    }
    .div1{
        width: 500px;
        height:100px;
        background-color: red;
    }
    .div2{
        width: 750px;
        height:100px;
        background-color: red;
        position: fixed;
    }
</style>
<script>

     import WxcButton from 'weex-ui/packages/wxc-button';
     import WxcPopup from 'weex-ui/packages/wxc-popup';
     import WxcOverlay from 'weex-ui/packages/wxc-overlay';

    module.exports = {
        components: { WxcButton, WxcPopup },
//        data: () => ({
//            isShow: false
//        }),
        data:{
            isShow: false,
            hidden1:false,
            widthpop:750,
        },
        methods: {
            buttonClicked3 () {
                    //this.isShow = false;
                   //this.widthpop = 0;
                   //this.hide();
                this.$refs.pop2.width=0
                    //this.width = 0;
            },
            buttonClicked () {
                if (!this.hidden1){
                    this.hidden1 = true
                }else{
                    this.isShow = true;

                }


            },
            overlayClicked () {
                this.isShow = false;
            }
        }
    };
</script>