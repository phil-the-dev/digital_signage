import consumer from "./consumer"

document.addEventListener("turbolinks:load", function () {
  const buttons = document.querySelectorAll('button.kiosk-control')

  for (let i = 0; i < buttons.length; i++) {
    let btn = buttons[i]
    consumer.subscriptions.create(
      { channel: "KioskChannel", kiosk_id: btn.dataset.kioskId }, {
      action: { pause: 'pause', play: 'play' },
      received(data) {
        if (data.action == this.action.pause) {
          btn.innerText = "Play";
        } else if (data.action == this.action.play) {
          btn.innerText = "Pause";
        }
      },

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

      uninstall() {

      },

      // Called when the subscription is rejected by the server.
      rejected() {
        this.uninstall()
      },

      update() {

      },

      install() {
        btn.onclick = function (e) {
          if (e.target.innerText === "Play") {
            this.perform(this.action.play)
          } else {
            this.perform(this.action.pause)
          }
        }.bind(this)
      },
    })

  }
})
document.addEventListener("turbolinks:load", function () {
  const kiosk_id = document.getElementById("kiosk-id")

  consumer.subscriptions.create(
    { channel: "KioskChannel", kiosk_id: kiosk_id.value }, {

    player: undefined,
    action: { pause: 'pause', play: 'play' },
    fetchPlayer() { return document.getElementById('main-player') },
    playerVisible() { return this.player != null; },
    fetchButton(kiosk_id) { return document.querySelector("button.kiosk-control[data-kiosk_id='" + kiosk_id + "']") },
    buttonVisible(kiosk_id) { return this.fetchButton(kiosk_id) != null },
    allButtons() { return },

    received(data) {
      if (data.action == this.action.pause) {
        if (this.playerVisible()) {
          this.player.pause();
        }
      } else if (data.action == this.action.play) {
        if (this.playerVisible()) {
          this.player.play();
        }
      }
    },

    // Called once when the subscription is created.
    initialized() {
      this.update = this.update.bind(this)
    },

    // Called when the subscription is ready for use on the server.
    connected() {
      this.player = this.fetchPlayer();
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
      if (this.player != null) {
        if (!this.player.dataset.isTransitioning) {
          !this.player.paused ? this.play() : this.pause()
        }
      }
    },

    play() {
      this.perform(this.action.play)
    },

    pause() {
      this.perform(this.action.pause)
    },

    install() {
      if (this.player != null) {
        this.player.onpause = this.update
        this.player.onplay = this.update
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
})