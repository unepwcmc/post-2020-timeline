<template>
  <div id="sticky" class="sticky-nav" :class="{'sticky-nav--stuck' : isSticky}">
    <slot>
      
    </slot>
  </div>
</template>

<script>
  export default {
    name: 'sticky-nav',

    data () {
      return {
        isSticky: false,
        triggerY: 0
      }
    },

    mounted () {
      this.createTiggerY
      this.scrollHandler()
    },

    methods: {
      createStickyTrigger () {
        const stickyElement = document.getElementById('sticky'),
              stickyElementHeight = stickyElement.clientHeight,
              stickyYOffset = stickyElement.getBoundingClientRect().top + window.pageYOffset

        this.triggerY = stickyElementHeight + stickyYOffset
      },

      scrollHandler () {
        // check the location of the window every 100ms to see whether the 
        // stick nav should be stuck or not
        setInterval( () => {
          let scrollY = window.pageYOffset

          this.isSticky = scrollY > this.triggerY ? true : false
        }, 100)
      }
    }
  }
</script>

<style lang="scss">
  .sticky-nav {
    z-index: 1;

    &--stuck {
      position: fixed;
    }
  }
</style>
