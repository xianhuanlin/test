<template>
    <scroller class="home">
        <card class="card1"></card>
        <card></card>
        <card></card>
        <card title="media"></card>
        <text>{{name}}</text>
    </scroller>

</template>



<style scoped>
.home{
    /*position: absolute;*/
    background-color: darkseagreen;

}

    .card1{
        background-color: blue;
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