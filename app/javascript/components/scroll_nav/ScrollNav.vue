<template>
  <ul class="v-scroll-nav scroll-nav ul-unstyled ul-inline">

    <li v-for="item in navArray" class="scroll-nav__item">
      <a 
        :id="'link-' + item" 
        :title="'See events in ' + item" 
        class="scroll-nav__link"
        @click.prevent="scroll(item)">
          {{ item }}
      </a>
    </li>
  </ul>
</template>

<script>
  import ScrollMagic from 'scrollmagic'
  import { eventHub } from '../../home.js'

  export default {
    name: 'scroll-nav',

    props: {
      navArray: {
        required: true,
        type: Array
      }
    },

    data () {
      return {
        navClass: '.v-scroll-nav',
        navY: 0,
        triggerOffset: 0,
        windowWidth: 0
      }
    },

    mounted () {
      // set the initial window width
      this.windowWidth = window.innerWidth

      // recalculate scene heights when the window is resized
      eventHub.$on('window-resized', this.windowResized)

      // set the offset value that triggers the active scroll link
      this.setTriggerOffset()

      // initiate scroll magin handlers
      this.scrollMagicHandlers()

      // set the start position of the timeline to the current event
      eventHub.$on('getCurrentEvent', this.currentEvent)
      
      // update scene durations
      eventHub.$once('pageLoadSceneDurations', this.updateScrollMagicDurations)
      eventHub.$on('updateSceneDurations', this.updateScrollMagicDurations)

      // monitor window resizing
      window.onresize = this.windowResized
    },

    methods: {
      currentEvent () {
        const event = document.getElementById('v-current-event')
        
        if(event) {
          const location = window.pageYOffset + event.getBoundingClientRect().top - this.triggerOffset - 10

          this.$store.commit('filters/updateCurrentEvent', location)

          eventHub.$emit('backToTop')
        }
      },

      // scroll down to the section of the page which corresponds to the
      // link that has been clicked
      scroll (year) {
        const offset = document.getElementById('year-' + year).offsetTop
        
        window.scrollTo({ top: offset - this.triggerOffset, behavior: 'smooth' })
      },

      // add scroll magic event listener for each nav item
      // so that the nav items change active state when scrolling
      // through different sections on the page
      scrollMagicHandlers () {
        let navScrollMagic = new ScrollMagic.Controller()
        let scrollMagicScenes = []

        // add scene for each item in the nav
        this.navArray.forEach(link => {
          let scene = {}
          const id = 'year-' + link

        
          scene.id = link

          scene.scene = new ScrollMagic.Scene({ 
            triggerElement: '#' + id, 
            triggerHook: 'onLeave' 
          })
          .offset(-this.triggerOffset)
          .setClassToggle('#link-' + link, 'scroll-nav__link--active')
          .addTo(navScrollMagic)

          scrollMagicScenes.push(scene)
        })

        this.scrollMagicScenes = scrollMagicScenes
      },

      setTriggerOffset () {
        // this offset accounts for the sticky bars at the top of the window
        this.triggerOffset = document.getElementById('v-header').clientHeight
      },

      updateScrollMagicDurations () {
        // update the scene durations (year div heights)
        this.scrollMagicScenes.forEach(scene => {
          let section = document.getElementById('year-' + scene.id)
          let height = 0


          if(section) height = section.clientHeight

          scene.scene.duration(height)
        })
      },

      windowResized () {
        // when the window width is resized the heights of the sticky bars and
        // years will change so update js accordingly
        const newWidth = window.innerWidth

        if(newWidth > this.windowWidth || newWidth < this.windowWidth) {
          this.setTriggerOffset()
          this.updateScrollMagicDurations()
          this.currentEvent()
          eventHub.$emit('getScrollY')

          this.windowWidth = newWidth
        }
      },

      openModal () {
        eventHub.$emit('openModal')
      }
    }
  }
</script>
