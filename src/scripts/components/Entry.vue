<template>
    <div class="hello2">{{ greeting }} <span>{{ name }}</span>!</div>
</template>

<script>
    export default {
        props: ['name'],
        data() {
            return {
                greeting: 'Hello2'
            }
        }
    };
</script>

<style>
    .hello2 {
        color: red;
    }

    .hello2 span {
        color: green;
    }
</style>
