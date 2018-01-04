<template>
  <div class="reveal__target" :class="{ 'reveal__target--active' : isActive }">
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

<style lang="scss">
  .reveal__target {
    position: absolute;
    top: 0;
    right: 0;
    bottom: 0;
    
    transform: translateX(100%);

    transition: transform .4s ease-in-out;

    &--active {
      transform: translateX(0);
    }
  }
</style>
