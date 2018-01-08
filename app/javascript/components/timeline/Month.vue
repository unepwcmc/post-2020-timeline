<template>
  <div class="timeline__month">
    {{ month }}

    <div class="timeline__events">
      
    </div>
  </div>
</template>

<script>
  export default {
    name: 'month',

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
