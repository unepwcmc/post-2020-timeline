<template>
  <div 
    v-bind:id="id" 
    class="timeline__event" 
    :class="{ 'timeline__event--current' : currentEvent, 'timeline__event--past' : pastEvent }"
    @click="openModal"
    >

    <div class="timeline__event__date flex-center">
      <span>{{ start }}</br>-</br>{{ end }}</span>
    </div>

    <span class="timeline__event__category">{{ categories }}</span>
    <span class="timeline__event__title">{{ title }}</span>
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
    },

    computed: {
      id () {
        return this.currentEvent ? 'v-current-event' : ''
      },

      start () {
        return this.styledDate(this.startDay)
      },

      end () {
        return this.styledDate(this.endDay)
      },

      categories () {
        return this.category.join(', ')
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
        obj['category'] = this.category
        obj['startDate'] = this.startDay + '/' + this.startMonth + '/' + this.startYear
        obj['endDate'] = this.endDay + '/' + this.endMonth + '/' + this.endYear
        obj['location'] = this.location
        obj['organisers'] = this.organisers.join(', ')
        obj['meetingSummary'] = this.meetingSummary
        obj['relevance'] = this.relevance
        obj['outputs'] = this.outputs

        this.$store.commit('modal/updateModalContent', obj)

        eventHub.$emit('openModal')
      }
    }
  }
</script>
