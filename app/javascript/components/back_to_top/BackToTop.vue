<template>
  <button class="back-to-top" @click="scroll('smooth')">
    <i class="icon icon--back-to-top"></i>
  </button>
</template>

<script>
  import { eventHub } from '../../home.js'
  import mixinScroll from '../../mixins/scroll'

  export default {
    name: 'back-to-top',

    mixins: [mixinScroll],

    created () {
      eventHub.$on('backToTop', this.scroll)
    },

    methods: {
      scroll (behavior = 'instant') {
        const currentEvent = this.$store.state.filters.currentEvent

        this.scrollTo({ top: currentEvent, behavior: behavior })
      }
    }
  }  
</script>
