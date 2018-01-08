<template>
  <div>
    {{ category }}
    {{ title }}
    {{ startDay }}
    {{ endDay }}
  </div>
</template>

<script>
  export default {
    name: 'event',

    props: {
      title: {
        required: true,
        type: String
      },
      category: {
        type: String
      },
      startDay: {
        required: true,
        type: String
      },
      endDay: {
        required: true,
        type: String
      }
    }
  }
</script>
