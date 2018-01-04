export const storeReveal = {
  namespaced: true,

  state: {
    active: false
  },

  mutations: {
    toggleActiveState () {
      this.state.reveal.active = !this.state.reveal.active
    }
  }
}