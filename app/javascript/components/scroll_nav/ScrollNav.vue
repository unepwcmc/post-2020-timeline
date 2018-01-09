<template>
  <ul class="v-scroll-nav scroll-nav ul-unstyled ul-inline">
    <li v-for="item in navArray"
      class="scroll-nav__item"
    >
      <a href="" :title="'See events in ' + item" class="scroll-nav__link">
        {{ item }}
      </a>
    </li>
  </ul>
</template>

<script>
  import ScrollMagic from 'scrollmagic'

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
        navY: 0
      }
    },

    mounted () {
      //this.navY = this.navClass.offset().top


      this.scrollMagicHandlers()
    },

    methods: {
      scroll (sectionId) {
        sectionY = $('#' + sectionId).offset().top - this.navHeight + 1

        $('html, body').animate({
          scrollTop: sectionY
        }, 400, function(){
          window.location.hash = sectionId
        })
      },

      // add scroll magic event listener for each nav item
      scrollMagicHandlers () {
        this.navScrollMagic = new ScrollMagic.Controller()

        let scrollMagicScenes = []

        // add scene for each item in the nav
        this.navArray.forEach(link => {
          let scene = {}
          
          scene.id = link.id

          scene.scene = new ScrollMagic.Scene({ 
            duration: self.getSceneDuration(link.id),
            triggerElement: '#' + link.id, 
            triggerHook: 'onLeave' 
          })
          .offset(-self.navHeight)
          .setClassToggle('#' + link.id + '-menu-item', 'v-sticky-nav__link-active')
          .addTo(self.navScrollMagic)

          scrollMagicScenes.push(scene)
        })

        this.scrollMagicScenes = scrollMagicScenes
      },
    }
  }
</script>
