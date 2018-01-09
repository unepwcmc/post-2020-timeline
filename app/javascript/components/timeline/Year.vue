<template>
  <div class="timeline__year">
    <span class="timeline__year-title">{{ year }}</span>
    
    <div class="timeline__months flex flex-column">
      <month v-for="month in months"
      :month="month.month"
      :events="month.events"
      >
      </month>
    </div>
  </div>
</template>

<script>
  import Month from './Month.vue'

  export default {
    name: 'year',

    components: { Month },

    props: {
      year: {
        required: true,
        type: Number
      },
      months: {
        required: true,
        type: Array
      }
    }
  }
</script>
