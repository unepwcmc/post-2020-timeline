<template>
  <div @click="clickTrigger()">
    <slot></slot>
  </div>
</template>

<script>
  import { eventHub } from '../../home.js'

  export default {
    name: 'reveal-trigger',

    props: {
      id: {
        required: true,
        type: String
      }
    },

    methods: {
      clickTrigger () {
        this.$store.commit('reveal/toggleActiveState')
      }
    }
  }
</script>