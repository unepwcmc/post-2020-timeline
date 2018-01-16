export const storeModal = {
  namespaced: true,

  state: {
    modalContent: {}
  },

  mutations: {
    updateModalContent (state, modalContent) {
      this.state.modal.modalContent = modalContent
    },
  }
}