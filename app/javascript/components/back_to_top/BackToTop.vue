<template>
  <button class="back-to-top" @click="scroll('smooth')">
    <i class="icon icon--back-to-top"></i>
  </button>
</template>

<script>
  import { eventHub } from '../../home.js'

  export default {
    name: 'back-to-top',

    created () {
      eventHub.$on('backToTop', this.scroll)
    },

    methods: {
      scroll (behavior = 'instant') {
        const currentEvent = this.$store.state.filters.currentEvent

        window.scrollTo({ top: currentEvent, behavior: behavior })
      }
    }
  }  
</script>
