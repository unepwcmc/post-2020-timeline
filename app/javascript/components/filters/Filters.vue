<template>
  <div class="filters">
    <h3 class="text-3">Filters</h3>

    <v-filter v-for="filter in filters"
      :name="filter.name"
      :title="filter.title"
      :options="filter.options"
      :type="filter.type"
    >
    </v-filter>

    <div class="filters__controls flex flex-h-between">
      <button @click="clear()" class="button button--plain">Clear</button>
      <button @click="apply()" class="button button--apply">Apply</button>
    </div>
  </div>  
</template>

<script>
  import { eventHub } from "../../home.js"
  import VFilter from './Filter.vue'

  export default {
    name: 'filters',

    components: { VFilter },

    props: {
      filters: {
        required: true,
        type: Array
      }
    },

    data () {
      return {
        children: this.$children,
        activeFilters: []
      }
    },

    mounted () {
      eventHub.$on('clickDropdown', this.updateDropdowns)
      eventHub.$on('closeReveal', this.cancel)
    },

    computed: {
      // create an array of all selected options in the child filters
      selectedFilters () {
        let arr = []

        this.children.forEach(filter => {
          let obj = {}
          const regex = new RegExp(' ', 'g')

          obj['name'] = filter.name.toLowerCase().replace(regex, '_')
          obj['type'] = filter.type
          obj['options'] = filter.selected

          arr.push(obj)
        })

        return arr
      },
    },

    methods: {
      updateDropdowns (name) {
        this.children.forEach(filter => {
          filter.isOpen = filter.name == name
        })
      },

      cancel() {
        eventHub.$emit('updateFilterOptionsState')
      },

      clear () {
        eventHub.$emit('clearSelected')
      },

      apply () {
        //update the active filters array
        this.activeFilters = this.selectedFilters

        this.$store.commit('filters/updateFilterOptions', this.activeFilters)

        eventHub.$emit('filterEvents')
        eventHub.$emit('applyFilters')
      }
    }
  }
</script>
