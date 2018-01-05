<template>
  <div class="filters">
    <h3 class="text-3">Filters</h3>

    <v-filter v-for="filter in filters"
      :name="filter.name"
      :title="filter.title"
      :options="filter.options"
    >
    </v-filter>

    <div class="filters__controls flex flex-h-between">
      <button @click="clear()" class="button button--link bold float-left">Clear</button>
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

      cancel() {
        this.closeSelect()
        
        // reset each option to the correct state
        this.children.forEach(child => {
          child.isSelected = this.activeOptions.includes(child.option) ? true : false
        })
      },

      clear () {
        eventHub.$emit('clearSelected')
      },

      apply () {
        this.closeSelect()

        //update the active filters array
        this.activeOptions = this.selectedOptions
        
        const newFilterOptions = {
          filter: this.name,
          options: this.activeOptions
        }

        this.$store.commit('updateFilterOptions', newFilterOptions)

        eventHub.$emit('callFilterItems')
      }
    }
  }
</script>
