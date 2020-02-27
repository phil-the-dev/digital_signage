import consumer from "./consumer"
console.log("kioskchannelstuff")
consumer.subscriptions.create("KioskChannel", {
  // Called once when the subscription is created.
  initialized() {
    this.update = this.update.bind(this)
  },

  // Called when the subscription is ready for use on the server.
  connected() {
    this.install()
    this.update()
  },

  // Called when the WebSocket connection is closed.
  disconnected() {
    this.uninstall()
  },

  // Called when the subscription is rejected by the server.
  rejected() {
    this.uninstall()
  },

  update() {
    this.isVideoPlaying ? this.appear() : this.away()
  },

  appear() {
    // Calls `AppearanceChannel#appear(data)` on the server.
    // this.perform("appear", { appearing_on: this.appearingOn })
    this.perform("playing")
  },

  away() {
    // Calls `AppearanceChannel#away` on the server.
    // this.perform("away")
    this.perform("paused")
  },

  install() {
    console.log("installing...")
    window.addEventListener("focus", this.update)
    window.addEventListener("blur", this.update)
    document.addEventListener("turbolinks:load", this.update)
    document.addEventListener("visibilitychange", this.update)
    document.getElementById('main-player').addEventListener("playing", this.update)
    document.getElementById('main-player').addEventListener("pause", this.update)
  },

  uninstall() {
    console.log("uninstalling...")
    window.removeEventListener("focus", this.update)
    window.removeEventListener("blur", this.update)
    document.removeEventListener("turbolinks:load", this.update)
    document.removeEventListener("visibilitychange", this.update)
    document.getElementById('main-player').removeEventListener("playing", this.update)
    document.getElementById('main-player').removeEventListener("pause", this.update)

  },

  get isVideoPlaying() {
    const player = document.getElementById('main-player');
    console.log(player)
    return player ? !player.paused : false;
  },

  // get appearingOn() {
  //   const element = document.querySelector("[data-appearing-on]")
  //   return element ? element.getAttribute("data-appearing-on") : null
  // }
})