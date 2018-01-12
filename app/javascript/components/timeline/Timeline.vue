<template>
  <div id="v-timeline" class="timeline">
    <year v-for="year in timeline"
      :year="year.year"
      :months="year.months"
    >
    </year>
  </div>
</template>

<script>
  import Year from './Year.vue'

  export default {
    name: 'timeline',

    components: { Year },

    props: {
      timeline: {
        requied: true,
        type: Array
      }
    }
  }
</script>
