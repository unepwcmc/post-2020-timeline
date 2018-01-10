<template>
  <ul class="v-scroll-nav scroll-nav ul-unstyled ul-inline">
    <li v-for="item in navArray" class="scroll-nav__item">
      <a 
        :id="'link-' + item" 
        href="" 
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
      // scroll down to the section of the page which corresponds to the
      // link that has been clicked
      scroll (year) {
        const section = document.getElementById('year-' + year).scrollIntoView({block: 'start', behavior: 'smooth'})
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
          
          scene.id = id

          scene.scene = new ScrollMagic.Scene({ 
            duration: this.getSceneDuration(link),
            triggerElement: '#' + id, 
            triggerHook: 'onLeave' 
          })
          // .offset(-self.navHeight)
          .setClassToggle('#link-' + link, 'scroll-nav__link--active')
          .addTo(navScrollMagic)

          scrollMagicScenes.push(scene)
        })

        // this.scrollMagicScenes = scrollMagicScenes
      },

      getSceneDuration (id) {
        var section = document.getElementById('year-' + id)

        return section.clientHeight
      }
    }
  }
</script>
