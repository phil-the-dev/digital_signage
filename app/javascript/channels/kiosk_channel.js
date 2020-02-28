import consumer from "./consumer"

consumer.subscriptions.create(
  { channel: "KioskChannel", room: 1 }, {
  received(data) {
    debugger
    console.log("got data", data)
  },

  // Called once when the subscription is created.
  initialized() {
    this.update = this.update.bind(this)
  },

  // Called when the subscription is ready for use on the server.
  connected() {
    setTimeout(function () {
      this.install()
      this.update()
    }.bind(this), 1000)

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
    const player = document.getElementById('main-player');
    if (player != null) {
      !player.paused ? this.play() : this.pause()
    }
  },

  play() {
    // Calls `AppearanceChannel#appear(data)` on the server.
    // this.perform("appear", { appearing_on: this.appearingOn })
    console.log("playing!!!")
    this.perform("playing", { kiosk: 1 })
    if (document.getElementById('kiosk-1') != null)
      document.getElementById('kiosk-1').innerText = "Pause"
  },

  pause() {
    // Calls `AppearanceChannel#away` on the server.
    // this.perform("away")
    console.log("pausing!!!")
    this.perform("paused", { kiosk: 1 })
    if (document.getElementById('kiosk-1') != null)
      document.getElementById('kiosk-1').innerText = "Play"
  },

  install() {
    console.log("installing...")
    const player = document.getElementById('main-player');


    // player.addEventListener("playing", this.update)
    // player.addEventListener("pause", this.update)
    if (player != null) {
      player.onpause = this.update
      player.onplay = this.update
    } else {
      document.getElementById('kiosk-1').onclick = function () {
        if (document.getElementById('kiosk-1').innerText === "Play") {
          this.perform("paused", { kiosk: 1, source: 'button' })
        } else {
          this.perform("play", { kiosk: 1, source: 'button' })

        }
      }.bind(this)
    }

  },

  uninstall() {
    console.log("uninstalling...")
    const player = document.getElementById('main-player');
    player.removeEventListener("playing", this.update)
    player.removeEventListener("pause", this.update)
  },

  get isVideoPlaying() {
    // console.log(this.player)
    const player = document.getElementById('main-player');
    console.log("isplaying", player ? !player.paused : false)
    return player ? !player.paused : false;
  },

  get player() {
    return document.getElementById('main-player');
  }
})
