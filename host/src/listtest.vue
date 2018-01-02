<template>
    <list class="list" @loadmore="fetch" loadmoreoffset="10">
        <cell class="cell" v-for="num in lists">
            <card :title="num">
                <!--<text class="text">{{num}}</text>-->
            </card>
        </cell>
    </list>
</template>

<script>
    import {Card} from './includes'
    const modal = weex.requireModule('modal')
    const LOADMORE_COUNT = 4

    export default {
        components:{ 'card':Card },
        data () {
            return {
                lists: [1, 2, 3, 4, 5]
            }
        },
        methods: {
            fetch (event) {
                modal.toast({ message: '重新加载完毕', duration: 0.5 })

                setTimeout(() => {
                    const length = this.lists.length
                    for (let i = length; i < length + LOADMORE_COUNT; ++i) {
                        this.lists.push(i + 1)
                    }
                }, 800)
            }
        }
    }
</script>

<style scoped>
    .panel {
        width: 600px;
        height: 250px;
        margin-left: 75px;
        margin-top: 35px;
        margin-bottom: 35px;
        flex-direction: column;
        justify-content: center;
        border-width: 2px;
        border-style: solid;
        border-color: rgb(162, 217, 192);
        background-color: rgba(162, 217, 192, 0.2);
    }
    .text {
        font-size: 50px;
        text-align: center;
        color: #41B883;
    }
</style>