<template>
    <div style="background-color: #0088fb" class="home">
        <div class="block">

        </div>
        <div class="block id2">

        </div>
        <!--<div class="block">-->

        <!--</div>-->
        <!--<div class="block">-->

        <!--</div>-->
    </div>
</template>
<style>
    .block{

        width: 100px;
        height: 100px;
        background-color: blanchedalmond;
    }
    .id2{
        margin-left: 0px;
        margin-right: 30px;
        /*margin-top: 30px;*/
        width: 240px;
        background-color: blueviolet;
    }
    .home{
        flex-direction: column;
        background-color: aquamarine;
        justify-content: center;
    }

</style>
<script>
    module.exports = {
        data: {
            data1: 1,
        },
        methods: {
            method1() {

            },
        }
    };
</script>