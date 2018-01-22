<template>
    <div>
        <div class="mainImage">
            <image></image>
            <text></text>
            <text></text>
            <text></text>
            <div>
                <text></text>
                <text></text>
            </div>
            <div v-for="num in deliverInfo">>
                <iamge></iamge>
                <text></text>
            </div>
        </div>

    </div>
</template>

<style scoped>
    .mainImage{

    }

</style>

<script>
    export default {
        components: {},
        data() {
            return {
                imageSet:[],
                deliverInfo:[],


                title: "card info",
                subTitle:"",
                price:"",
                detailUrl:"",



            }
        },
        methods: {
            update: function (e) {
                this.title = "click" + this.title

            }
        }
    }
</script>