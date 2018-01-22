<template>
  <div :id="id" class="timeline__year v-year" :class="{ 'timeline__year--past' : pastYear }">
    <span class="timeline__year-title">{{ year }}</span>

    <div class="timeline__months flex flex-column">
      <month  v-for="month in months"
        :month="month.month"
        :events="month.events"
        :pastMonth="month.past_month"
        >
      </month>
    </div>

    <div v-if="noEvents" class="timeline__message-month flex">
      <div class="timeline__message-wrapper">
        <div class="timeline__message">
          <span class="timeline__event__title">No Events Listed</span>
          <p>Check alternative years or change filter options to view events.</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { eventHub } from '../../home.js'
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

    updated () {
      eventHub.$emit('getCurrentEvent')
    },

    data () {
      return {
        children: this.$children
      }
    },

    computed: {
      id () {
        return 'year-' + this.year
      },

      noEvents () {
        let activeEvents = 0

        this.children.forEach(month => {
          activeEvents += month.activeEvents
        })

        return activeEvents === 0
      }
    }
  }
</script>
