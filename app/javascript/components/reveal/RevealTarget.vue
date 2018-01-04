<template>
  <div :class="{ 'reveal__target--active' : isActive }">
    <slot></slot>  
  </div>
</template>

<script>
  import { eventHub } from '../../home.js'

  export default {
    name: 'reveal-target',

    props: {
      id: {
        required: true,
        type: String
      },
      type: {
        required: true,
        type: String
      }
    },

    data() {
      return {
        // isActive: this.$store.state.reveal.active
      }
    },

    computed: {
      isActive () {
        return this.$store.state.reveal.active
      }
    },

    methods: {
      openReveal (id) {
        console.log('id', id)
      }
    }
  }
</script>
