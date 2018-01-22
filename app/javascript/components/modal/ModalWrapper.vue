<template>
  <div class="modal-wrapper flex-h-center" :class="{ 'modal-wrapper--active' : isActive }" @click.self="closeModal">
  </div>
</template>

<script>
  import { eventHub } from '../../home.js'

  export default {
    name: 'modal-wrapper',

    computed: {
      isActive () {
        return this.$store.state.modal.isActive
      }
    },

    methods: {
      closeModal () {
        // make sure the current event is at the top of the page
        // when the first modal is closed
        if(this.$store.state.modal.isFirstModal) {
          this.$store.commit('modal/notFirstModal')

          eventHub.$emit('getCurrentEvent')
        }

        this.$store.commit('modal/updateModalStatus')
      },
    }
  }
</script>

<style lang="scss">
  .modal-wrapper {
    display: none;
    position: fixed;
    top: 0;
    right: 0;
    bottom: 0;
    left: 0;
    z-index: 5;

    &--active { display: flex; }
  }
</style>