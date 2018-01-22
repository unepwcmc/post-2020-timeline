<template>
  <div @click="closeWrapper()" class="reveal-wrapper" :class="{ 'reveal-wrapper--active' : isActive }"></div>
</template>

<script>
  import { eventHub } from '../../home.js'

  export default {
    name: 'reveal-wrapper',

    computed: {
      isActive () {
        return this.$store.state.reveal.active
      }
    },

    methods: {
      closeWrapper () {
        this.$store.commit('reveal/toggleActiveState')

        eventHub.$emit('closeReveal')
      }
    }
  }  
</script>

<style lang="scss">
  .reveal-wrapper { 
    display: none;
    position: fixed;
    top: 0;
    right:0;
    bottom: 0;
    left: 0;
    z-index: 9;

    &--active { display: block; }
  }  
</style>
