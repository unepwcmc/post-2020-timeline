export const storeModal = {
  namespaced: true,

  state: {
    modalContent: {},
    isActive: false,
    isFirstModal: true
  },

  mutations: {
    updateModalContent (state, modalContent) {
      this.state.modal.modalContent = modalContent
    },

    updateModalStatus () {
      this.state.modal.isActive = !this.state.modal.isActive
    },

    notFirstModal () {
      this.state.modal.isFirstModal = false
    }
  }
}