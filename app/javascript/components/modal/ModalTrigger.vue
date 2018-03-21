<template>
  <div @click="triggerModal()">
    <slot></slot>
  </div>
</template>

<script>
  import { eventHub } from '../../home.js'

  export default {
    name: 'modal-trigger',

    props: [ 'type' ],

    methods: {
      triggerModal () {
        const type = this.type ? this.type : ''

        eventHub.$emit('triggerModal', type)
      }
    }
  }  
</script>
