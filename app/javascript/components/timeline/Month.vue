<template>
  <div v-show="hasActiveEvents" class="timeline__month" :class="{ 'timeline__month--past' : pastMonth }">
    <span class="timeline__month-title">{{ month }}</span>

    <div class="timeline__events">
      <event v-for="event in events"
        v-show="event.isActive"
        :category="event.category"
        :title="event.title"
        :startDay="event.start_day"
        :startMonth="event.start_month"
        :startYear="event.start_year"
        :endDay="event.end_day"
        :endMonth="event.end_month"
        :endYear="event.end_year"
        :organisers="event.organisers"
        :location="event.location"
        :relevance="event.relevance"
        :meetingSummary="event.summary"
        :outputs="event.outputs"
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

    data () {
      return {
        inactiveFilters: false,
        activeEvents: 0,
        children: this.$children
      }
    },

    created () {
      this.updateActiveEvents(true)
    },

    mounted () {
      eventHub.$on('updateActiveEvents', this.updateActiveEvents)
    },

    computed: {
      hasActiveEvents () {
        return this.activeEvents > 0
      }
    },

    methods: {
      updateActiveEvents (pageLoad = false) {
        const activeFilters = this.$store.state.filters.activeFilters

        // keep track of whether the month has any active events
        let activeEvents = 0
        
        this.events.forEach(event => {
          // show all the events on page load
          if(pageLoad) {

            this.$set(event, 'isActive', true)
            activeEvents++

          } else {
            let filterMatch = true

            // loop through all filters for each event to see if there is a match
            activeFilters.forEach(activeFilter => {

              // if there are some selected options check to see if one matches
              if (activeFilter.options.length !== 0) {
                let optionMatch = false

                activeFilter.options.forEach(option => {
                  if(event[activeFilter.name] == option) {
                    optionMatch = true
                  }
                })

                // once filterMatch is set to false it will always be false and the item
                // will not be shown because it did not match at least one option in every active filter
                filterMatch = filterMatch && optionMatch
              }
              
              // update the active state of each the event
              this.$set(event, 'isActive', filterMatch)

              if(filterMatch) activeEvents++
            })
          }
        })

        // update properties so that the active state of the month can be calculated
        this.activeEvents = activeEvents
      }
    }
  }
</script>
