<template>
    <div>


    </div>
</template>

<style scoped>


</style>

<script>
    export default {
        components: {},
        data() {
            return {
                name: "card",
                title: "card info",
                info: "2014-11-20过期",
                backsrc: "../res/card.png",
            }
        },
        methods: {
            update: function (e) {
                this.title = "click" + this.title

            }
        }
    }
</script>