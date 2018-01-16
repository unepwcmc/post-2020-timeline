<template>
  <div class="modal-wrapper flex-h-center" :class="{ 'modal-wrapper--active' : isActive }" @click.self="closeModal">
    <div class="modal">
      <div class="modal__title-box">
        <p><p>{{ modalContent.category }}</p></p>
        <h3><p>{{ modalContent.title }}</p></h3>

        <button class="button button--close button--close-black modal__close" @click="closeModal"></button>
      </div>

      <p>{{ modalContent.startDate }}</p>
      <p>{{ modalContent.endDate }}</p>
      <p>{{ modalContent.location }}</p>
      
      <h4>Organisers</h4>
      <p>{{ modalContent.organisers }}</p>

      <h4>Meeting summary</h4>
      <p>{{ modalContent.meetingSummary }}</p>

      <h4>Relevance to post 2020</h4>
      <p>{{ modalContent.relevance }}</p>

      <h4>Outputs</h4>
      <p>{{ modalContent.outputs }}</p>
    </div>
  </div>
</template>

<script>
  import { eventHub } from '../../home.js'

  export default {
    name: 'modal',

    data () {
      return {
        isActive: false,
        modalContent: {}
      }
    },

    created () {
      eventHub.$on('openModal', this.openModal)

      this.updateModalContent()
    },

    methods: {
      openModal () {
        this.updateModalContent()
        this.isActive = !this.isActive

      },

      closeModal () {
        this.isActive = false
      },

      updateModalContent () {
        this.modalContent = this.$store.state.modal.modalContent
      }
    }
  }
</script>
