<template>
  <div :id="id" class="timeline__year v-year" :class="{ 'timeline__year--past' : pastYear }">
    <span class="timeline__year-title">{{ year }}</span>
    
    <div class="timeline__months flex flex-column">
      <month v-for="month in months"
      :month="month.month"
      :events="month.events"
      :pastMonth="month.past_month"
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
      },
      pastYear: {
        required: true,
        type: Boolean
      }
    },

    computed: {
      id () {
        return 'year-' + this.year
      }
    }
  }
</script>
