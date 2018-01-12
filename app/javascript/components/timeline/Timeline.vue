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
  import { eventHub } from '../../home.js'
  import Year from './Year.vue'

  export default {
    name: 'timeline',

    components: { Year },

    props: {
      timeline: {
        requied: true,
        type: Array
      }
    },

    data () {
      return {
        years: []
      }
    },

    created () {
      eventHub.$on('filterEvents', this.filterEvents)

      this.years = this.timeline
    },

    mounted () {

    },

    methods: {
      filterEvents () {
        const activeFilters = this.$store.state.filters.activeFilters

        // loop through all events
        this.years.forEach(year => {
          year.months.forEach(month => {
            month.events.forEach(event => {
              let filterMatch = true

              // loop through all filters for each event to see if there is a match
              activeFilters.forEach(filter => {

                if (filter.options.length !== 0) {
                  let optionMatch = false

                  filter.options.forEach(option => {

                    if(event[filter.name] == option) { console.log('match')}
                  })
                }

                // once filterMatch is set to false it will always be false and the item
                // will not be shown because it did not match at least one option in every active filter
                filterMatch = filterMatch && optionMatch
              })
            })
          })
        })
      }
    }
  }
</script>
