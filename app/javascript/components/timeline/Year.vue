<template>
  <div>
    {{ year }}
  </div>
</template>

<script>
  export default {
    name: 'year',

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
