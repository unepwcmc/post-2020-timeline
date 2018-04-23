<template>
  <div class="popover">
    <div class="popover__trigger" "icon--contact-popover">
      <span class="icon--contact-popover"></span>
    </div>
    <div class="popover__box"></div>
  </div>
</template>

<script>
  import { eventHub } from '../../home.js'
  export default {
    name: 'popover',
    data () {
      return {
        isActive: false
      }
    },
    created () {
      eventHub.$on('showPopover', this.togglePopover)
    },
    methods: {
      togglePopover () {
        this.isActive = !this.isActive
      }
    }
  }
</script>

<style lang="scss">
  .popover {
    position: absolute;
    z-index: 2000;
  }
</style>
