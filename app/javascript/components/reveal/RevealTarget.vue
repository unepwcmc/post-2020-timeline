<template>
  <div class="reveal--target" :class="{ 'reveal--target--active' : isActive }">
    <button @click="closeReveal" class="reveal--target__button button button--plain button--close"></button>
    <slot></slot>  
  </div>
</template>

<script>
  import { eventHub } from '../../home.js'

  export default {
    name: 'reveal-target',

    computed: {
      isActive () {
        return this.$store.state.reveal.active
      }
    },

    created () {
      eventHub.$on('applyFilters', this.applyFilters)
    },

    methods: {
      closeReveal () {
        this.$store.commit('reveal/toggleActiveState')

        eventHub.$emit('closeReveal')
      },

      applyFilters () {
        this.$store.commit('reveal/toggleActiveState')        
      }
    }
  }
</script>

<style lang="scss">
  .reveal--target {
    position: fixed;
    top: 0;
    right: 0;
    bottom: 0;
    z-index: 10;
    
    transform: translateX(100%);

    transition: transform .4s ease-in-out;

    &--active {
      transform: translateX(0);
    }
  }
</style>
