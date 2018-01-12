<template>
  <div id="v-sticky" class="sticky">
    <div id="v-topbar" class="sticky--stuck sticky__topbar">
      <slot></slot>
    </div> 
    
    <div id="v-header-wrapper" class="temp sticky--stuck" :class="{ 'sticky--absolute' : isAbsolute }">

      <div id="v-header">
        <slot name="header"></slot>
      </div>

      <div id="v-control-bar" class="control-bar-wrapper" :class="{'sticky--stuck' : isControlBarSticky}">
        <div class="sticky__control-bar">
        <!-- <div class="sticky__control-bar" > -->
          <slot name="control-bar"></slot>
        </div>
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
        topbarHeight: 0,
        headerTrigger: 0,
        currentEvent: 0,
        headerHeight: 0,
        scrollY: 0,
        isAbsolute: false,
        headerAbsolute: false
      }
    },

    mounted () {
      // add margin to the top of the timeline to push it below the fixed header
      this.headerHeight = document.getElementById('v-topbar').clientHeight + document.getElementById('v-header-wrapper').clientHeight
      this.setOffset()

      document.getElementById('v-header-wrapper').style.top = document.getElementById('topbar').clientHeight + 'px'

      // create trigger for collapsible header
      this.setStickyTrigger()
      this.scrollHandler()

      // check for changes to the window width
      this.monitorResize()
    },

    methods: {
      setStickyTrigger () {
        const current = document.getElementById('v-current-event'),
              event = current.offsetTop,
              parent = current.offsetParent.offsetHeight

        // this.currentEvent = event + parent
        this.currentEvent = current.getBoundingClientRect().top
      },

      setOffset () {
        document.getElementById('v-timeline').style.paddingTop = this.headerHeight + 'px'
      },

      scrollHandler () {
        window.addEventListener('scroll', () => {
          const current = document.getElementById('v-current-event').getBoundingClientRect().top

          this.scrollY = window.pageYOffset
          this.headerTrigger = this.scrollY + current - this.headerHeight
          this.topbarHeight = document.getElementById('topbar').clientHeight + 'px'

          this.checkHeader()
          this.checkControlBar()
        })
      },

      // when the user scrolls past the current event make the header
      // absolute so that it scrolls off the page
      checkHeader () {
        const headerWrapper = document.getElementById('v-header-wrapper')

        if(this.scrollY > this.headerTrigger){
            
          if(!this.headerAbsolute) {
            this.isAbsolute = true
            this.headerAbsolute = true

            const tempOffset = document.getElementById('topbar').clientHeight

            headerWrapper.style.top = this.scrollY + tempOffset  +'px'
          }

        } else {
          this.headerAbsolute = false
          this.isAbsolute = false
          headerWrapper.style.top = this.topbarHeight
        }
      },

      // when the control bar reaches the topbar make it sticky
      checkControlBar () {
        const controlBar = document.getElementById('v-control-bar'),
              header = document.getElementById('v-header').clientHeight,
              controlBarTrigger = this.headerTrigger + header

        if(this.scrollY > controlBarTrigger){
          this.isControlBarSticky = true
          controlBar.style.top = this.topbarHeight
        } else {
          this.isControlBarSticky = false
        }
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

    // &--hidden { display: none; }
    &--absolute { 
      position: absolute;
    }

    &__topbar {
      z-index: 2;
    }
  }
</style>
