export const vCloakRemove = () => document.addEventListener('DOMContentLoaded', () => {
    document.querySelector('#vue-app').removeAttribute('v-cloak')
  })