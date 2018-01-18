<template>
  <button class="back-to-top" @click="scroll">
    <i class="icon icon--back-to-top"></i>
  </button>
</template>

<script>
  import { eventHub } from '../../home.js'

  export default {
    name: 'back-to-top',

    created () {
      eventHub.$on('back-to-top', this.scroll)
    },

    methods: {
      scroll () {
        const currentEvent = this.$store.state.filters.currentEvent

        window.scrollTo({ top: currentEvent, behavior: 'smooth' })
      }
    }
  }  
</script>
