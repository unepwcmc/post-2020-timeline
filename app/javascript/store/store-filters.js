export const storeFilters = {
  namespaced: true,

  state: {
    activeFilters: [],
    currentEvent: 0
  },

  mutations: {
    updateFilterOptions (state, filterOptions) {
      this.state.filters.activeFilters = filterOptions
    },

    updateCurrentEvent (state, currentEvent) {
      this.state.filters.currentEvent = currentEvent
    }
  }
}