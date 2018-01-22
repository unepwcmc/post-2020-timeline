<template>
  <div class="modal" :class="{ 'modal--active' : isActive }" :style="{ 'top' : topPosition }">

    <div v-if="hero">
      <button class="button button--close button--close-black modal__close" @click="closeModal"></button>
      <slot></slot>
    </div>
    
    <div v-else>
      <div class="modal__title-box">
        <p class="modal__category">{{ categories }}</p>
        <h3>{{ modalContent.title }}</h3>

        <button class="button button--close button--close-black modal__close" @click="closeModal"></button>
      </div>
      
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
        <h4>Relevance to post 2020</h4>
        <p>{{ modalContent.relevance }}</p>
      </template>
      
      <template v-if="hasContent(modalContent.outputs)">
        <h4>Outputs</h4>
        <p>{{ modalContent.outputs }}</p>
      </template>
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
        isActive: true,
        modalContent: {},
        top: 0,
        hero: true
      }
    },

    created () {
      eventHub.$on('openModal', this.openModal)
      eventHub.$on('closedModalWrapper', this.toggleModal)
    },

    computed: {
      topPosition () {
        return this.top + 'px'
      },

      categories () {
        return this.modalContent.category && this.modalContent.category.length ? this.modalContent.category.join(', ') : ''
      }
    },

    methods: {
      toggleModal () {
        this.isActive = !this.isActive
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
        this.toggleModal()
          
        eventHub.$emit('closeModalWrapper')
      },

      getScrollY () {
        // add top padding if being viewed on medium or large breakpoints
        this.top = window.innerWidth <= this.config.smallBreakpoint ? window.scrollY : window.scrollY + 40
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