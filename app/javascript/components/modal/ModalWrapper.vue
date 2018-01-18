<template>
  <div class="modal-wrapper flex-h-center" :class="{ 'modal-wrapper--active' : isActive }" @click.self="closeModal">
  </div>
</template>

<script>
  import { eventHub } from '../../home.js'

  export default {
    name: 'modal-wrapper',

    data () {
      return {
        isActive: true
      }
    },

    created () {
      eventHub.$on('openModal', this.toggleModal)
      eventHub.$on('closeModalWrapper', this.toggleModal)
    },

    methods: {
      toggleModal () {
        this.isActive = !this.isActive
      },

      closeModal () {
        this.toggleModal()

        eventHub.$emit('closedModalWrapper')
      }
    }
  }
</script>
