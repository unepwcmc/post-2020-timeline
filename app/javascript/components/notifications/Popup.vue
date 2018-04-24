<template>
  <div class="popup">
    <div class="popup__trigger icon--contact-popup" @click="togglePopup">
      <span class="icon--social icon--contact"></span>
    </div>
    <div class="popup__box__arrow_up" v-show="isActive"></div>
    <div class="popup__box" v-show="isActive">
      Contact us at post-2020@unep-wcmc.org
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
