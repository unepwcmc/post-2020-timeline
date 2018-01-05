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

    mounted () {
      eventHub.$on('clickDropdown', this.updateDropdowns)
      eventHub.$on('closeReveal', this.cancel)
    },

    data () {
      return {
        children: this.$children,
        activeOptions: []
      }
    },

    computed: {

    },

    methods: {
      updateDropdowns (name) {
        this.children.forEach(filter => {
          filter.isOpen = filter.name == name
        })
      },

      cancel() {
        console.log('cancel')
        // this.closeSelect()
        
        // // reset each option to the correct state
        // this.children.forEach(child => {
        //   child.isSelected = this.activeOptions.includes(child.option) ? true : false
        // })
      },

      clear () {
        eventHub.$emit('clearSelected')
      },

      apply () {
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
