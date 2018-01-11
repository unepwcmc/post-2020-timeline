<template>
  <div id="sticky" class="sticky">
    <slot></slot>
    <slot name="header" class="sticky__header"></slot>

    <div class="control-bar-wrapper">
      <div class="sticky__control-bar" :class="{'sticky--stuck control-bar--stuck' : isControlBarSticky}">
        <slot name="control-bar"></slot>
      </div>
    </div>
  </div>
</template>

<script>
  import { eventHub } from '../../home.js'

  export default {
    name: 'sticky',

    data () {
      return {
        config: {
          breakpoints : {
            small: 720 //this MUST match the breakpoint set variables.scss
          }
        },
        isControlBarSticky: false,
        headerHeight: 0,
        scrollY: 0
      }
    },

    mounted () {
      // create trigger for collapsible header
      this.setStickyTrigger()
      this.scrollHandler()

      // check for changes to the window width
      this.monitorResize()
    },

    methods: {
      setStickyTrigger () {
        this.headerHeight = document.getElementById('header').clientHeight
      },

      scrollHandler () {
        // check the location of the window every 100ms to see whether the 
        // sticky elements should be stuck or not
        setInterval( () => {
          this.scrollY = window.pageYOffset

          this.checkHeader()
        }, 100)
      },

      checkHeader () {
        this.isControlBarSticky = this.scrollY > this.headerHeight ? true : false
      },

      monitorResize () {
        window.addEventListener('resize', () => {
          let width = window.clientWidth

          this.setStickyTrigger()

          eventHub.$emit('window-resized')
        })
      }
    }
  }
</script>

<style lang="scss">
  .sticky {
    &--stuck {
      width: 100%;

      position: fixed;
      z-index: 1;
    }
  }
</style>
