export const storeFilters = {
  namespaced: true,

  state: {
    activeFilters: []
  },

  mutations: {
    updateFilterOptions (state, filterOptions) {
      this.state.filters.activeFilters = filterOptions
    }
  }
}