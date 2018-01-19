<template>
  <div v-show="hasActiveEvents" class="timeline__month" :class="{ 'timeline__month--past' : pastMonth }">
    <span class="timeline__month-title">{{ month }}</span>

    <div class="timeline__events">
      <event v-for="event in events"
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
        :cbdRelation="event.cbd_relation"
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
        children: this.$children
      }
    },

    computed: {
      activeEvents () {
        let activeEvents = 0

        this.children.forEach(child => {
          if(child.isActive) activeEvents++
        })

        return activeEvents
      },

      hasActiveEvents () {
        return this.activeEvents > 0
      }
    }
  }
</script>
