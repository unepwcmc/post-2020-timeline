export const storeReveal = {
  namespaced: true,

  state: {
    active: true
  },

  mutations: {
    toggleActiveState () {
      this.state.reveal.active = !this.state.reveal.active
    }
  }
}