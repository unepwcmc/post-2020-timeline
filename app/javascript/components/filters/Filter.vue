<template>
  <div class="filter">

    <p
      @click="openSelect()" 
      class="filter__button button flex flex-v-center" 
      :class="{ 'filter__button--active' : isOpen , 'filter__button--has-selected' : hasSelected }">

      <span>{{ title }}</span><span v-show="hasSelected" class="filter__button-total">{{ totalSelectedOptions }}</span>
    </p>

    <ul class="filter__options ul-unstyled" :class="{ 'filter__options--active' : isOpen }">
      <filter-option v-for="option in options" 
        :option="option">
      </filter-option>
    </ul>
  </div>
</template>

<script>
  import { eventHub } from '../../home.js'
  import FilterOption from './FilterOption.vue'

  export default {
    name: 'v-filter',

    components: { FilterOption },

    props: {
      name: {
        required: true,
        type: String
      },
      title: {
        required: true,
        type: String
      },
      options: {
        required: true,
        type: Array
      }
    },

    data () {
      return {
        isOpen: false,
        children: this.$children
      }
    },

    created () {
      eventHub.$on('updateFilterOptionsState', this.updateFilterOptionsState)
    },

    computed: {
      // create an array of all selected options in this filter
      selectedOptions () {
        let selectedArray = []

        this.children.forEach(child => {
          if(child.isSelected){ 
            selectedArray.push(child.option)
          }
        })

        return selectedArray
      },

      hasSelected () {
        return this.totalSelectedOptions > 0
      },

      totalSelectedOptions () {
        return this.selectedOptions.length
      },
    },

    methods: {
      openSelect () {
        // if the filter is open is close it, else open it and close the others
        if(this.isOpen){
          this.isOpen = false
        } else {
          eventHub.$emit('clickDropdown', this.name)  
        }
      },

      closeSelect () {
        this.isOpen = false
      },

      // set each option to the correct selected state
      updateFilterOptionsState () {
        const activeFilters = this.$store.state.filters.activeFilters

        // get the activeFilter object that matches the current filter
        let activeFilter = activeFilters.filter(activeFilter => {
          return activeFilter.name == this.name
        })

        // check to see if the filter options are present in the array of active options
        this.children.forEach(child => {
          child.isSelected = activeFilter[0].options.includes(child.option) ? true : false
        })
      }
    }
  }
</script>
