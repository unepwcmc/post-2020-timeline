<template>
  <div class="timeline__month">
    {{ month }}

    <div class="timeline__events">
      <event v-for="event in events"
        :category="event.category"
        :title="event.title"
        :startDay="event.start_day"
        :endDay="event.end_day"
      ></event>
    </div>
  </div>
</template>

<script>
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
      }
    }
  }
</script>
