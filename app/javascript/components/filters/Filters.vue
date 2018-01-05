<template>
  <div class="filters">
    <h3 class="text-3">Filters</h3>

    <v-filter v-for="filter in filters"
      :name="filter.name"
      :title="filter.title"
      :options="filter.options"
    >
    </v-filter>
  </div>  
</template>

<script>
  import { eventHub } from "../../home.js"
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

    mounted () {
      eventHub.$on('clickDropdown', this.updateDropdowns)
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
        ],
        children: this.$children
      }
    },

    methods: {
      updateDropdowns (name) {
        this.children.forEach(filter => {
          filter.isOpen = filter.name == name
        })
      },
    }
  }
</script>
