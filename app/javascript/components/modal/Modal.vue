<template>
  <div class="modal" :class="{ 'modal--active' : isActive, 'modal--hero' : hero }" :style="{ 'top' : topPosition }">

    <div v-if="hero">
      <div class="modal--hero__content">
        <button class="button button--close-round button--close-black modal--hero__close" @click="closeModal"></button>
        
        <slot></slot>

        <button class="button button--secondary" @click="closeModal">Explore</button>
      </div>
    </div>
    
    <div v-else>
      <div class="modal__title-box">
        <h3>{{ modalContent.title }}</h3>

        <button class="button button--close button--close-black modal__close" @click="closeModal"></button>
      </div>
      
      <div class="modal__content">
        <div class="modal__info-box">
          <span class="flex flex-v-center">
            <i class="icon icon--calendar modal__icon--calendar"></i>{{ modalContent.startDate }} - {{ modalContent.endDate }}
          </span>
          
          <template v-if="hasContent(modalContent.location)">
            <span class="flex flex-v-center">
              <i class="icon icon--pin modal__icon--pin"></i> {{ modalContent.location }}
            </span>
          </template>
        </div>
        
        <template v-if="hasContent(modalContent.organisers)">
          <h4>Organisers</h4>
          <p>{{ modalContent.organisers }}</p>
        </template>
        
        <template v-if="hasContent(modalContent.meetingSummary)">
          <h4>Meeting summary</h4>
          <p>{{ modalContent.meetingSummary }}</p>
        </template>
        
        <template v-if="hasContent(modalContent.relevance)">
          <h4>Relevance to the post-2020 global biodiversity framework</h4>
          <p>{{ modalContent.relevance }}</p>
        </template>
        
        <template v-if="hasContent(modalContent.outputs)">
          <h4>Links to further information</h4>
          <p>{{ modalContent.outputs }}</p>
        </template>
      </div>
    </div>
  </div>
</template>

<script>
  import { eventHub } from '../../home.js'

  export default {
    name: 'modal',

    data () {
      return {
        config: {
          smallBreakpoint: 720 // must match scss file
        },
        modalContent: {},
        top: 0,
        hero: true
      }
    },

    created () {
      // open the modal for the first time after the page has been scrolled 
      // to the current event location
      eventHub.$once('pageLoadModal', this.openModal)

      eventHub.$on('openModal', this.openModal)

      eventHub.$on('getScrollY', this.getScrollY)
    },

    computed: {
      isActive () {
        return this.$store.state.modal.isActive
      },

      topPosition () {
        return this.top + 'px'
      }
    },

    methods: {
      toggleModal () {
        this.$store.commit('modal/updateModalStatus')
      },

      openModal ( hero = true ) {
        this.hero = hero
        
        // get the y position and open the modal and modal wrapper
        this.getScrollY()
        
        // update the modal with the latest event content
        if(!this.hero){ this.modalContent = this.$store.state.modal.modalContent }

        this.toggleModal()
      },

      closeModal () {
        // make sure the current event is at the top of the page
        // when the hero modal is first closed
        if(this.$store.state.modal.isFirstModal) {
          this.$store.commit('modal/notFirstModal')

          eventHub.$emit('getCurrentEvent')
        }

        this.toggleModal()
      },

      getScrollY () {
        // add top padding if being viewed on medium or large breakpoints
        this.top = window.innerWidth <= this.config.smallBreakpoint ? window.pageYOffset : window.pageYOffset + 40
      },

      hasContent (property) {
        return !!property
      }
    }
  }
</script>

<style lang="scss">
  .modal {
    display: none;
    position: absolute;
    top: 0;
    left: 0;
    z-index: 6;

    &--active { display: block; }
  }
</style>