<template>
  <div class="timeline__month" :class="{ 'timeline__month--past' : pastMonth }">
    <span class="timeline__month-title">{{ month }}</span>

    <div class="timeline__events">
      <event v-for="event in events"
        v-show="event.isActive"
        :category="event.category"
        :title="event.title"
        :startDay="event.start_day"
        :endDay="event.end_day"
        :currentEvent="event.current_event"
        :pastEvent="event.past_event"
      ></event>
    </div>
  </div>
</template>

<script>
  import { eventHub } from '../../home.js'
  import Event from './Event.vue'

  export default {
    name: 'month',

    components: { Event },

    props: {
      month: {
        required: true,
        type: String
      },
      events: {
        type: Array
      },
      pastMonth: {
        required: true,
        type: Boolean
      }
    },

    created () {
      this.updateActiveEvents(true)
    },

    mounted () {
      eventHub.$on('updateActiveEvents', this.updateActiveEvents)
    },

    methods: {
      updateActiveEvents (pageLoad = false) {
        const activeFilters = this.$store.state.filters.activeFilters
        
        this.events.forEach(event => {
          // show all the events on page load
          if(pageLoad) {

            this.$set(event, 'isActive', true)

          } else {
            let filterMatch = true
            let activeEvents = []

            // loop through all filters for each event to see if there is a match
            activeFilters.forEach(filter => {

              if (filter.options.length !== 0) {
                let optionMatch = false

                filter.options.forEach(option => {
                  if(event[filter.name] == option) optionMatch = true
                })

                // once filterMatch is set to false it will always be false and the item
                // will not be shown because it did not match at least one option in every active filter
                filterMatch = filterMatch && optionMatch
              }

              // update the active state of each the event
              this.$set(event, 'isActive', filterMatch)
            })
          }
        })
      }
    }
  }
</script>
