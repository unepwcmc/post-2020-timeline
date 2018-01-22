export const storeModal = {
  namespaced: true,

  state: {
    modalContent: {},
    isActive: false
  },

  mutations: {
    updateModalContent (state, modalContent) {
      this.state.modal.modalContent = modalContent
    },

    updateModalStatus () {
      this.state.modal.isActive = !this.state.modal.isActive
    }
  }
}