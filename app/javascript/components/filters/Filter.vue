<template>
  <div class="filter">
    
    <p v-if="type === 'multiple'"
      @click="openSelect()" 
      class="filter__button filter__button-controls button flex flex-v-center" 
      :class="{ 'filter__button--active' : isOpen }">

      <span>{{ title }}</span><span v-show="hasSelected" class="filter__button-total">{{ totalSelectedOptions }}</span>
    </p>

    <p v-else class="filter__button button flex flex-v-center filter__button--active">
      <span>{{ title }}</span>
    </p>

    <ul v-if="type === 'multiple'" class="filter__options ul-unstyled" :class="{ 'filter__options--active' : isOpen }">
      <li v-for="option in options" class="filter__option flex flex-h-start flex-v-center">

        <input
          type="checkbox" 
          :id="optionId(option)" 
          v-model="selectedCheckbox" 
          :name="name" 
          :value="option" 
          class="filter__checkbox" 
          :class="{ 'filter__checkbox--active' : isSelected(option) }">
        
        <label :for="optionId(option)" class="filter__checkbox-label">{{ option }}</label>
      </li>
    </ul>

    <ul v-else class="filter__options ul-unstyled filter__options--active">
      <li v-for="option in options" class="filter__option flex flex-h-start flex-v-center">

        <input v-if="type === 'radio'" 
          type="radio" 
          :id="optionId(option)" 
          v-model="selectedRadio" 
          :name="name" 
          :value="option" 
          class="filter__radio">    
        
        <label :for="optionId(option)" class="filter__checkbox-label">{{ option }}</label>
      </li>
    </ul>
  </div>
</template>

<script>
  import { eventHub } from '../../home.js'

  export default {
    name: 'v-filter',

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
      },
      type: {
        required: true,
        type: String
      }
    },

    data () {
      return {
        isOpen: false,
        children: this.$children,
        selectedCheckbox: [],
        selectedRadio: 'Show all'
      }
    },

    created () {
      eventHub.$on('updateSelected', this.updateSelected)
      eventHub.$on('clearSelected', this.clearSelected)

      if(!this.isCheckboxes) this.isOpen = true
    },

    computed: {
      // ensure the format of selected is an array
      selected () {
        let selected = []

        if(this.type == 'multiple') selected = this.selectedCheckbox
        if(this.type == 'radio') selected.push(this.selectedRadio)

          return selected
      },

      totalSelectedOptions () {
        return this.selected.length
      },

      hasSelected () {
        return this.totalSelectedOptions > 0
      },

      isCheckboxes () {
        return this.type === 'multiple'
      }
    },

    methods: {
      openSelect () {
        if(!this.isCheckboxes) return false

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

      clearSelected () {
        this.selectedCheckbox = []
        this.selectedRadio = 'Show all'
      },

      // the cancel button has been pressed, reset the selected option
      updateSelected () {
        const activeFilters = this.$store.state.filters.activeFilters

        // get the activeFilter object that matches the current filter
        let activeFilter = activeFilters.filter(activeFilter => {
          return activeFilter.name == this.name
        })

        // update the selected filter options for the correct filter type
        if(activeFilter.length) {
          const options = activeFilter[0].options

          if(this.type === 'multiple') this.selectedCheckbox = options
          if(this.type === 'radio') this.selectedRadio = options[0]
        }
      },

      optionId (string) {
        return string.replace(' |(|)|_', '-').toLowerCase()
      },

      isSelected (string) {
        // use indexOf so it works in IE
        return this.selected.indexOf(string) != -1
      },

      underscoreToPascal (string) {
        const regex = new RegExp('/_([a-z])/g')

        return string.replace(regex, () => { return g[1].toUpperCase() })
      }
    }
  }
</script>
