<template>
  <div class="popup">
    <div class="popup__trigger icon--contact-popup" @click="togglePopup">
      Contact <span class="icon--social icon--social-email"></span>
    </div>
    <div class="popup__box" v-show="isActive">
      Popup content
    </div>
  </div>
</template>

<script>
  export default {
    name: 'popup',

    data () {
      return {
        isActive: false
      }
    },

    methods: {
      togglePopup () {
        this.isActive = !this.isActive
      }
    }
  }
</script>

<style lang="scss">
  .popup {
    position: relative;

    &__box {
      position: absolute;
    }
  }
</style>
