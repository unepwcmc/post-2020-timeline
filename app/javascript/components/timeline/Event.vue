<template>
  <div 
    v-show="isActive"
    v-bind:id="id" 
    class="timeline__event" 
    :class="{ 'timeline__event--current' : currentEvent, 'timeline__event--past' : pastEvent }"
    @click="openModal"
    >

    <div class="timeline__event__date flex-center">
      <span>{{ start }}</br>-</br>{{ end }}</span>
    </div>

    <span class="timeline__event__title">{{ truncatedTitle }}</span>
  </div>
</template>

<script>
  import { eventHub } from '../../home.js'

  export default {
    name: 'event',

    props: {
      title: { 
        required: true, 
        type: String 
      },
      category: { 
        type: Array 
      },
      organisers: { 
        type: Array 
      },
      location: { 
        type: String 
      },
      outputs: { 
        type: String 
      },
      relevance: { 
        type: String 
      },
      meetingSummary: { 
        type: String
      },
      startDay: { 
        required: true,
        type: String 
      },
      startMonth: { 
        required: true,
        type: String
      },
      startYear: { 
        required: true,
        type: Number
      },
      endDay: { 
        required: true,
        type: String
      },
      endMonth: { 
        required: true, 
        type: String 
      },
      endYear: { 
        required: true, 
        type: Number 
      },
      currentEvent: { 
        required: true, 
        type: Boolean 
      },
      pastEvent: { 
        required: true,
        type: Boolean
      },
      cbdRelation: {
        required: true,
        type: String
      }
    },

    updated () { 
      eventHub.$emit('updateSceneDurations')
    },
    
    computed: {
      isActive () {
        return this.checkIfActive()
      },

      id () {
        return this.currentEvent ? 'v-current-event' : ''
      },

      start () {
        return this.styledDate(this.startDay)
      },

      end () {
        return this.styledDate(this.endDay)
      },

      truncatedTitle () {
        const title = this.title
        const length = title.length
        const characters = 60

        let output

        if (length <= characters) {
          output = title
        } else {
          output = title.substring(0, characters -3) + '...'
        }

        return output
      }
    },
    
    methods: {
      styledDate (day) {
        let styled

        if( day == '01' || day == '21' || day == '31') {
          styled = day + 'st'

        } else  if( day == '02' || day == '22') {
          styled = day + 'nd'

        } else  if( day == '03' || day == '23') {
          styled = day + 'rd'

        } else {
          styled = day + 'th'
        }

        return styled
      },

      openModal () {
        // create object of event information and commit to store
        let obj = {}

        obj['title'] = this.title
        obj['startDate'] = this.startDay + '/' + this.startMonth + '/' + this.startYear
        obj['endDate'] = this.endDay + '/' + this.endMonth + '/' + this.endYear
        obj['location'] = this.location
        obj['organisers'] = this.organisers.join(', ')
        obj['meetingSummary'] = this.meetingSummary
        obj['relevance'] = this.relevance
        obj['outputs'] = this.outputs

        this.$store.commit('modal/updateModalContent', obj)

        eventHub.$emit('openModal', false)
      },

      checkIfActive () {
        //check if the event has any matching properties in each filter
        const activeFilters = this.$store.state.filters.activeFilters
        let filterMatch = true

        // loop through all filters for each event to see if there is a match
        activeFilters.forEach(activeFilter => {
          if(activeFilter.options.length !== 0) {
            const filterProp = this.underscoreToPascal(activeFilter.name)
            let optionMatch = false

            if(activeFilter.type == 'multiple') {
              optionMatch = this.hasCheckboxMatch(activeFilter, filterProp)
            }

            if(activeFilter.type == 'radio') {
              optionMatch = this.hasRadioButtonMatch(activeFilter, filterProp)
            }

            // once filterMatch is set to false it will always be false and the item
            // will not be shown because it did not match at least one option in every active filter
            filterMatch = filterMatch && optionMatch
          }
        })

        return filterMatch
      },

      hasCheckboxMatch (activeFilter, filterProp) {
        let hasMatch = false

        activeFilter.options.forEach(option => {
          // use indexOf so it works in IE
          if(this[filterProp].indexOf(option) != -1) hasMatch = true
        })

        return hasMatch
      },

      hasRadioButtonMatch (activeFilter, filterProp) {
        const selectedRadio = activeFilter.options[0]

        //if the radio button is 'show all' return true for all events
        if(selectedRadio.toLowerCase() == 'show all'){
          return true
        } else {
          // use indexOf so it works in IE
          if(this[filterProp].indexOf(selectedRadio) != -1) return true
        }

        return false
      },

      underscoreToPascal (string) {
        const regex = new RegExp(/_([a-z])/g)

        return string.replace(regex, g => { return g[1].toUpperCase() })
      }
    }
  }
</script>
