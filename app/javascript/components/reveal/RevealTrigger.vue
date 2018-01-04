<template>
  <div @click="clickTrigger()">
    <slot></slot>
  </div>
</template>

<script>
  import { eventHub } from '../../home.js'

  export default {
    name: 'reveal-trigger',

    methods: {
      clickTrigger () {
        this.$store.commit('reveal/toggleActiveState')
      }
    }
  }
</script>
