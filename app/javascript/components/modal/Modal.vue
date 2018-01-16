<template>
  <div class="modal-wrapper flex-h-center" :class="{ 'modal-wrapper--active' : isActive }" @click.self="closeModal">
    <div class="modal">
      <div class="modal__title-box">
        <p>Category</p>
        <h3>Title</h3>

        <button class="button button--close button--close-black modal__close" @click="closeModal"></button>
      </div>
      
      <h4>Organisers</h4>
      <p></p>

      <h4>Meeting summary</h4>

      <h4>Relevance to post 2020</h4>

      <h4>Outputs</h4>
    </div>
  </div>
</template>

<script>
  import { eventHub } from '../../home.js'

  export default {
    name: 'modal',

    data () {
      return {
        isActive: false
      }
    },

    created () {
      eventHub.$on('openModal', this.openModal)
    },

    methods: {
      openModal () {
        this.isActive = !this.isActive
      },

      closeModal () {
        this.isActive = false
      }
    }
  }
</script>
