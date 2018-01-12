<template>
  <div id="v-header" class="sticky sticky--stuck">
    <slot></slot>
    
    <div class="temp" :class="{ 'sticky--hidden' : isClosed }">
      <slot name="header"></slot>
    </div>

    <div class="control-bar-wrapper">
      <div class="sticky__control-bar">
      <!-- <div class="sticky__control-bar" :class="{'sticky--stuck control-bar--stuck' : isControlBarSticky}"> -->
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
        currentEvent: 0,
        headerHeight: 0,
        scrollY: 0,
        isClosed: false
      }
    },

    mounted () {
      // add margin to the top of the timeline to push it below the fixed header
      this.headerHeight = document.getElementById('v-header').clientHeight
      this.setOffset()

      // create trigger for collapsible header
      this.setStickyTrigger()
      this.scrollHandler()

      // check for changes to the window width
      this.monitorResize()
    },

    methods: {
      setStickyTrigger () {
        this.headerHeight = document.getElementById('header').clientHeight

        const current = document.getElementById('v-current-event'),
              event = current.offsetTop,
              parent = current.offsetParent.offsetHeight

        // this.currentEvent = event + parent
        this.currentEvent = current.getBoundingClientRect().top
      },

      setOffset () {
        document.getElementById('v-timeline').style.marginTop = this.headerHeight + 'px'
      },

      scrollHandler () {
        window.addEventListener('scroll', () => {
          console.log('scroll')
          this.scrollY = window.pageYOffset
          const current = document.getElementById('v-current-event')

          console.log('y', this.scrollY)
          console.log('current', current.getBoundingClientRect().top)

          this.isClosed = this.scrollY > this.scrollY + current.getBoundingClientRect().top ? true : false
        })

        // check the location of the window every 100ms to see whether the 
        // sticky elements should be stuck or not
        // setInterval( () => {
        //   this.scrollY = window.pageYOffset

        //   this.checkHeader()
        // }, 100)
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
      top: 0;
      z-index: 1;
    }

    &--hidden { display: none; }
  }
</style>
