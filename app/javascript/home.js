import Vue from 'vue/dist/vue.esm'
import store from './store/store.js'
import Filters from './components/filters/Filters.vue'
import RevealTarget from './components/reveal/RevealTarget.vue'
import RevealTrigger from './components/reveal/RevealTrigger.vue'
import Timeline from './components/timeline/Timeline.vue'

// create event hub and export so that it can be imported into .vue files
export const eventHub = new Vue()

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#v-app',
    store,
    components: { Filters, RevealTarget, RevealTrigger, Timeline }
  })
})