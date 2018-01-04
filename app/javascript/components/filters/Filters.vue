<template>
  <div class="filters">
    <h3>Filters</h3>

    <v-filter v-for="filter in filters"
      :name="filter.name"
      :title="filter.title"
      :options="filter.options"
    >
    </v-filter>
  </div>  
</template>

<script>
  import VFilter from './Filter.vue'

  export default {
    name: 'filters',

    components: { VFilter },

    props: {
      // filters: {
      //   required: true,
      //   type: Array
      // }
    },

    data () {
      return {
        filters: [
          {
            name: 'category',
            title: 'category',
            options: ['category 1', 'category 2'],
            multiple: false
          },
          {
            name: 'organisers',
            title: 'organisers',
            options: ['organiser 1', 'organiser 2'],
            multiple: true
          }
        ]
      }
    },

    created () {
      console.log('filters', this.filters)
    },

    methods: {

    }
  }
</script>
