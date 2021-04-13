export default {
  computed: {
    isIE () {
      return Boolean(window.navigator.userAgent.match(/(MSIE|Trident)/))
    }
  },

  methods: {
    scrollTo ({ left=0, top=0, behavior=nil }) {
      if (this.isIE) {
        window.scrollTo(left, top)
      } else {
        window.scrollTo({ left, top, behavior })
      }
    }
  }
}