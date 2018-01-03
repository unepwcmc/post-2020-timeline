import Vue from 'vue/dist/vue.esm'
import store from './store/store.js'
import Timeline from './components/timeline/Timeline.vue'

// create event hub and export so that it can be imported into .vue files
export const eventHub = new Vue()

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#v-app',
    store,
    components: { Timeline }
  })
})