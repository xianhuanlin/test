<template>
    <scroller class="home">
        <card></card>
        <card></card>
        <card></card>
        <card></card>
        <text>{{name}}</text>
    </scroller>

</template>



<style scoped>
.home{
    /*position: absolute;*/
    background-color: darkseagreen;

}
</style>

<script>
    import {Card} from './includes'

    export default {
        components:{ 'card':Card },
        data:{
            name: "test2",
        },
        method:{

        }

    }
</script>