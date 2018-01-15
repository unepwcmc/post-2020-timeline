export const storeFilters = {
  namespaced: true,

  state: {
    activeFilters: [],
    selectedFilterOptions: []
  },

  mutations: {
    updateFilterOptions (state, filterOptions) {
      this.state.filters.activeFilters = filterOptions
    },
  }
}