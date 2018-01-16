<template>
  <button class="back-to-top" @click="scrollUp">
    <i class="icon icon--back-to-top"></i>
  </button>
</template>

<script>
  export default {
    name: 'back-to-top',

    methods: {
      scrollUp () {
        const currentEvent = this.$store.state.filters.currentEvent

        window.scrollTo({ 'top': currentEvent })
      }
    }
  }  
</script>
