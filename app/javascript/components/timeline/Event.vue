<template>
  <div class="timeline__event">
    <div class="timeline__event__date flex-center">
      <span>{{ start }}</br>-</br>{{ end }}</span>
    </div>

    <span class="timeline__event__category">{{ category }}</span>
    <span class="timeline__event__title">{{ title }}</span>
  </div>
</template>

<script>
  export default {
    name: 'event',

    props: {
      title: {
        required: true,
        type: String
      },
      category: {
        type: String
      },
      startDay: {
        required: true,
        type: String
      },
      endDay: {
        required: true,
        type: String
      }
    },

    computed: {
      start () {
        return this.styledDate(this.startDay)
      },

      end () {
        return this.styledDate(this.endDay)
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
      }
    }
  }
</script>