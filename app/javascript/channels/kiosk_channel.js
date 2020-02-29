import consumer from "./consumer"

consumer.subscriptions.create(
  { channel: "KioskChannel", kiosk_id: 1 }, {

  player: undefined,
  button: undefined,
  action: { pause: 'pause', play: 'play' },
  fetchPlayer() { return document.getElementById('main-player') },
  fetchButton() { return document.getElementById('kiosk-1') },
  playerVisible() { return this.player != null; },
  buttonVisible() { return this.button != null; },

  received(data) {
    if (data.action == this.action.pause) {
      if (this.playerVisible()) {
        this.player.pause();
      } else if (this.buttonVisible()) {
        this.button.innerText = "Play"
      }
    } else if (data.action == this.action.play) {
      if (this.playerVisible()) {
        this.player.play();
      } else if (this.buttonVisible()) {
        this.button.innerText = "Pause"
      }
    }
  },

  // Called once when the subscription is created.
  initialized() {
    this.update = this.update.bind(this)
  },

  // Called when the subscription is ready for use on the server.
  connected() {
    setTimeout(function () {
      this.player = this.fetchPlayer();
      this.button = this.fetchButton();

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
    if (this.player != null) {
      !this.player.paused ? this.play() : this.pause()
    }
  },

  play() {
    this.perform("playing", { kiosk: 1 })
    if (this.button != null)
      this.button.innerText = "Pause"
  },

  pause() {
    this.perform(this.action.pause, { kiosk: 1 })
    if (this.button != null)
      this.button.innerText = "Play"
  },

  install() {
    if (this.player != null) {
      this.player.onpause = this.update
      this.player.onplay = this.update
    } else if (this.button != null) {
      this.button.onclick = function (e) {
        if (e.target.innerText === "Play") {
          this.perform(this.action.play, { kiosk: 1 })
        } else {
          this.perform(this.action.pause, { kiosk: 1 })
        }
      }.bind(this)
    }
  },

  uninstall() {
    this.player.removeEventListener("playing", this.update)
    this.player.removeEventListener("pause", this.update)
  },

  get isVideoPlaying() {
    return this.player ? !this.player.paused : false;
  },
})
