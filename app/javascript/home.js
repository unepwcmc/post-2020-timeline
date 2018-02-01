import hoverCheck from './hoverCheck.js'

import Vue from 'vue/dist/vue.esm'
import store from './store/store.js'
import BackToTop from './components/back_to_top/BackToTop.vue'
import Filters from './components/filters/Filters.vue'
import Modal from './components/modal/Modal.vue'
import ModalWrapper from './components/modal/ModalWrapper.vue'
import RevealWrapper from './components/reveal/RevealWrapper.vue'
import RevealTarget from './components/reveal/RevealTarget.vue'
import RevealTrigger from './components/reveal/RevealTrigger.vue'
import Timeline from './components/timeline/Timeline.vue'
import ScrollNav from './components/scroll_nav/ScrollNav.vue'

import ScrollMagic from 'scrollmagic'

// create event hub and export so that it can be imported into .vue files
export const eventHub = new Vue()

// create vue instance and attach to the DOM
document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#v-app',
    store,
    components: { BackToTop, Filters, Modal, ModalWrapper, RevealWrapper, RevealTarget, RevealTrigger, Timeline, ScrollNav }
  })
})
