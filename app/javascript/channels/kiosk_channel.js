import consumer from "./consumer"
const action = { pause: 'pause', play: 'play' };

document.addEventListener("turbolinks:load", function () {
  const buttons = document.querySelectorAll('button.kiosk-control')

  for (let i = 0; i < buttons.length; i++) {
    let btn = buttons[i]
    consumer.subscriptions.create(
      { channel: "KioskChannel", kiosk_id: btn.dataset.kioskId }, {

      received(data) {
        if (data.action == action.pause) {
          btn.innerText = "Play";
        } else if (data.action == action.play) {
          btn.innerText = "Pause";
        }
      },

      // Called once when the subscription is created.
      initialized() {
        // this.update = this.update.bind(this)
      },

      // Called when the subscription is ready for use on the server.
      connected() {
        this.install()
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

      install() {
        btn.onclick = function (e) {
          if (e.target.innerText === "Play") {
            this.perform(action.play)
          } else {
            this.perform(action.pause)
          }
        }.bind(this)
      },
    })
  }
})

document.addEventListener("turbolinks:load", function () {
  const kiosk_id = document.getElementById("kiosk-id");
  const player = document.getElementById('main-player');

  if (kiosk_id) {
    consumer.subscriptions.create(
      { channel: "KioskChannel", kiosk_id: kiosk_id.value }, {

      received(data) {
        if (data.action == action.pause) {
          player.pause();
        } else if (data.action == action.play) {
          player.play();
        }
      },

      // Called once when the subscription is created.
      initialized() {
        this.update = this.update.bind(this)
      },

      // Called when the subscription is ready for use on the server.
      connected() {
        this.install()
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
        if (!player.dataset.isTransitioning) {
          !player.paused ? this.perform(action.play) : this.perform(action.pause)
        }
      },

      install() {
        player.onpause = this.update
        player.onplay = this.update
      },

      uninstall() {
        player.removeEventListener("playing", this.update)
        player.removeEventListener("pause", this.update)
      },
    })
  }
})